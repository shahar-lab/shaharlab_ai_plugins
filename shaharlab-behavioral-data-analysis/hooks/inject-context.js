#!/usr/bin/env node
// SessionStart hook: injects the Shahar Lab always-on rules as session context.
const fs = require("fs");
const path = require("path");

const contextDir = path.join(__dirname, "..", "context");
const files = [
  "orchestrator.md",
  "project-rules.md",
  "coding-rules.md",
  "path-enforcement.md",
  "lab-linter.md",
];

const parts = [];
for (const f of files) {
  const p = path.join(contextDir, f);
  if (fs.existsSync(p)) {
    const body = fs.readFileSync(p, "utf8").trim();
    if (body) parts.push(`<!-- ${f} -->\n${body}`);
  }
}

process.stdout.write(
  JSON.stringify({ additionalContext: parts.join("\n\n---\n\n") })
);
