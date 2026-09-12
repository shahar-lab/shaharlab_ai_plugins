# Rules for the `preprocessing/` main-folder

These rules are binding. Do not break them.

1. `data/collected/` is read-only. Never write to it, rename it, move it, tidy it, or change it by any other means.
   
2. `preprocessing/` is a single job-folder. Never add a job-folder inside it. Never change its structure: `code/`, `artifacts/`, `output/`, `main.R`, and `summary.md` are the tree; nothing else.
