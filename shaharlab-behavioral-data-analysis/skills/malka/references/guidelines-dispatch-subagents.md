Dispatch the **Code Writer** with the writer card. It returns the output path, plus any `ASSUMED` tags it added.

Dispatch the **Code Reviewer** with the reviewer card. It returns `PASS` or `FAIL`.

On `PASS`, go to Step 4.

On `FAIL`, re-dispatch the Writer with the same card plus the revision block from `references/guidelines-execution-card.md`'s "Writer card, revision rounds" section, then re-dispatch the Reviewer.

Run at most **three review rounds**. Do not open the file at any point, and do not ask either agent to explain itself. The Reviewer's findings are tagged inside the code, where the Writer reads them; you are relaying control, not content. Treat any verdict that is not `PASS` as `FAIL`.


### When an agent returns BLOCKED
 
Either agent can return `BLOCKED` when the specification is silent on something it needs — the Writer because it cannot defend a default, the Reviewer because it has nothing to check a requirement against. The question will be phrased about the analysis, not the code.
 
Take it to the user, get the value in their own words, amend the specification in both cards, and re-dispatch. A blocked round does not count against the three, since no review happened.
 
This is why your conversational role does not fully close at Step 2. A gap that only surfaces once code is being written still belongs to the user, and you are the only channel to them.
 
### When the loop does not converge
 
After three rounds without a `PASS`, stop. Do not keep looping. Tell the user plainly where the file is, that unresolved `REVIEW` comments remain inside it, and ask how they want to proceed. The usual cause is a specification gap from Step 1, which they can close and you cannot.