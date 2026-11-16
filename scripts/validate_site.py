#!/usr/bin/env python3
"""Validate generated page coverage and local links, including HTML fragments."""
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit
import sys

ROOT = Path(__file__).resolve().parents[1]
SITE = ROOT / '_site'

class Page(HTMLParser):
    def __init__(self):
        super().__init__()
        self.ids = set()
        self.links = []
    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if 'id' in attrs:
            self.ids.add(attrs['id'])
        for key in ('href', 'src'):
            if key in attrs:
                self.links.append(attrs[key])

pages = {}
errors = []
if (SITE / "maintenance").exists():
    errors.append("Private maintenance files copied into rendered site")
for p in SITE.rglob('*.html'):
    page = Page()
    page.feed(p.read_text())
    pages[p.resolve()] = page
for source in ROOT.rglob('*.qmd'):
    if any(part in {'_site', 'maintenance'} for part in source.parts):
        continue
    target = SITE / source.relative_to(ROOT).with_suffix('.html')
    if not target.is_file():
        errors.append(f"Missing rendered page: {target.relative_to(SITE)}")
for p, page in pages.items():
    for link in page.links:
        uri = urlsplit(link)
        if uri.scheme or uri.netloc or link.startswith('javascript:'):
            continue
        dest = (SITE / unquote(uri.path).lstrip('/') if uri.path.startswith('/')
                else p.parent / unquote(uri.path)) if uri.path else p
        dest = dest.resolve()
        if dest.is_dir():
            dest /= 'index.html'
        if not dest.exists():
            errors.append(f"Broken link: {p.relative_to(SITE)} -> {link}")
        elif uri.fragment and dest in pages and unquote(uri.fragment) not in pages[dest].ids:
            errors.append(f"Missing anchor: {p.relative_to(SITE)} -> {link}")
if errors:
    print('\n'.join(sorted(set(errors))))
    sys.exit(1)
print(f"Validated {len(pages)} rendered pages and their local links and anchors.")
