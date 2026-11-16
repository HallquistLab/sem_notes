#!/usr/bin/env python3
"""Check source navigation, local resources, portable paths, and excluded artifacts."""
from pathlib import Path
from urllib.parse import unquote, urlsplit
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
errors = []
sources = sorted(p for p in ROOT.rglob('*.qmd')
                 if not any(part in {'_site', 'maintenance'} for part in p.parts))
config = (ROOT / '_quarto.yml').read_text()
for p in sources:
    text = p.read_text()
    rel = p.relative_to(ROOT)
    if str(rel) not in config:
        errors.append(f"Missing navigation: {rel}")
    if not text.startswith('---\n') or '\ntitle:' not in text:
        errors.append(f"Missing Quarto title metadata: {rel}")
    if re.search(r'(?m)^output:', text):
        errors.append(f"Legacy R Markdown output metadata: {rel}")
    if 'maintenance/' in text:
        errors.append(f"Private editorial link in published page: {rel}")
    if '/Users/' in text or '~/Box' in text:
        errors.append(f"Machine-specific path: {rel}")
    if 'install.packages(' in re.sub(r'```(?:bash|sh).*?```', '', text, flags=re.S):
        errors.append(f"Package installation during rendering: {rel}")
    prose = re.sub(r'```.*?```', '', text, flags=re.S)
    targets = re.findall(r'!?\[[^\]]*\]\(([^\s)]+)', prose)
    targets += re.findall(r'<img[^>]+src=[\"\']([^\"\']+)', prose)
    for target in targets:
        uri = urlsplit(target)
        if uri.scheme or uri.netloc or not uri.path:
            continue
        target_path = (p.parent / unquote(uri.path)).resolve()
        if not target_path.is_relative_to(ROOT) or not target_path.exists():
            errors.append(f"Missing local resource: {rel}: {target}")
        elif target_path.name not in {x.name for x in target_path.parent.iterdir()}:
            errors.append(f"Resource filename case mismatch: {rel}: {target}")
for p in ROOT.rglob('*'):
    if any(part in {'.git', '_site', '.quarto', 'maintenance'} for part in p.parts):
        continue
    if p.is_file() and (p.suffix.lower() in {'.rmd', '.docx', '.pptx', '.psd'}
                        or p.name.startswith(('q_and_a.', '13_qa.'))
                        or 'KEY' in p.name):
        errors.append(f"Unwanted course artifact: {p.relative_to(ROOT)}")
if errors:
    print('\n'.join(errors))
    sys.exit(1)
print(f"Validated {len(sources)} Quarto pages, navigation, local resources, and exclusions.")
