## Prefer tokensave MCP tools

Before reading source files or scanning the codebase, use the tokensave MCP tools (`tokensave_context`, `tokensave_search`, `tokensave_callers`, `tokensave_callees`, `tokensave_impact`, `tokensave_node`, `tokensave_files`, `tokensave_affected`). They provide instant semantic results from a pre-built knowledge graph and are faster than file reads.

If a code analysis question cannot be fully answered by tokensave MCP tools, try querying the SQLite database directly at `.tokensave/tokensave.db` (tables: `nodes`, `edges`, `files`). Use SQL to answer complex structural queries that go beyond what the built-in tools expose.

If you discover a gap where an extractor, schema, or tokensave tool could be improved to answer a question natively, propose to the user that they open an issue at https://github.com/aovestdipaperino/tokensave describing the limitation. **Remind the user to strip any sensitive or proprietary code from the bug description before submitting.**


## Token-efficient fallback

Use tokensave only when the tokensave MCP tools are available in the current runtime. If they are unavailable, do not spend tokens searching for them, reading setup docs, or trying multiple failing calls. State once that tokensave is unavailable in this environment, then use the narrowest normal file-discovery command allowed by the file-discovery rules.
