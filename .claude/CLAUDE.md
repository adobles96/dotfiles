These are some personal preferences for working together.

## Code Style
- Simplicity is the crowning reward of art (to quote Chopin)
- Don't overinherit (deep inheritances obscure logic)
- Don't introduce abstractions prematurely
- No blanket try-excepts
- Don't try to handle every edgecase from the start. Tests will bubble those up eventually, keep things simple to start.

## The Dev Log
I like to make use of a little dev log system to keep track of the work we do. Each relevant repo will
have a (gitignored) directory at the root called `dev_log/`. In it there are three subdirs: `active`,
`completed` and `killed`. Each directory holds markdown notes corresponding to projects we're either actively working on,
already completed or decided to stop working on.

The project markdown notes follow the naming convention `yyyy-mm-dd_project_name.md`. For example `2026-03-12_train_eda.md`.
Each note has two main sections:
1. Overview: this will have a project description and any useful context such as relevant files/scripts/commands
and things we've learned along the way.
2. Log: this section has subsections with date titles (eg `### 2026-03-14`) where agents write summaries of whatever we worked on that day/session, key things we changed, anything we tried that didn't actually make the cut, and pending work. Log entries should follow descending order, ie most recent entries first.

At the end of a working session I may ask you to fill in the changelog entry for the relevant project or even update the overview section
if need be.
