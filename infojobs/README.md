# InfoJobs Content Pack

This folder contains InfoJobs-ready CV content as an independent derived output.

## Canonical Source
- data/cv-es.json

## Generated Output
- infojobs/es/profile.md

## Update Workflow
1. Update canonical JSON source in data/cv-es.json.
2. Regenerate output: python3 scripts/generate-infojobs.py.
3. Review the generated diff before commit.

## Notes
- Do not edit generated files manually.
- The generator currently produces Spanish InfoJobs output.