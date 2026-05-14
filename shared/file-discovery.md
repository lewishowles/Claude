## File discovery

Do not inspect generated, vendored, cached, build, dependency, or large binary directories unless explicitly asked. Prefer `rg` / `rg --files`, which respects `.gitignore` and `.rgignore`. Avoid `find`, broad `ls -R`, or reading ignored paths such as `node_modules`, `dist`, `build`, `.git`, coverage, caches, lockfile-heavy generated output, and local secrets.
