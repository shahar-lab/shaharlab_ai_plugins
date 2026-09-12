# Flow

How a request moves through Malka. This file will grow; the Interview is what is drawn so far.

```mermaid
%%{init: {"flowchart": {"subGraphTitleMargin": {"top": 24, "bottom": 24}, "padding": 32, "rankSpacing": 56, "nodeSpacing": 40}}}%%
flowchart TD
  newScience["1. New science"]
  subgraph interview [Interview]
    direction TB
    planCard["2. Build a plan card"]
    clarify["3. Clarify"]
    confirm["4. Confirm"]
    planCard --> clarify
    clarify --> confirm
    confirm -->|"repeat if needed"| clarify
  end
  newScience --> planCard
```

**New science** sits outside the Interview. A different formula or a new cutoff is new science: it starts a new Interview.

Inside **Interview**, the three beats run in order: build a Plan Card, then Clarify, then Confirm. Confirm can send the work back to Clarify and then forward again until the user approves.
