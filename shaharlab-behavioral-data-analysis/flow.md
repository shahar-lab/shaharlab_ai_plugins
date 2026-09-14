# Flow

How a request moves through Malka. This file will grow; the Interview is what is drawn so far.

```mermaid
%%{init: {"flowchart": {"subGraphTitleMargin": {"top": 24, "bottom": 24}, "padding": 32, "rankSpacing": 56, "nodeSpacing": 40}}}%%
flowchart TD
  newScience["1. New science"]
  subgraph interview [Interview]
    direction TB
    jobCards["2. Job Cards"]
    clarify["3. Clarify"]
    confirm["4. Confirm"]
    jobCards --> clarify
    clarify --> confirm
    confirm -->|"repeat if needed"| clarify
  end
  newScience --> jobCards
```

**New science** sits outside the Interview. A different formula or a new cutoff is new science: it starts a new Interview.

Inside **Interview**, Malka creates one Job Card per job-folder, then Clarifies and Confirms them. Confirm can return affected Job Cards to Clarify until the user approves.
