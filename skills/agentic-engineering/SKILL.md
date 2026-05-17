---
name: agentic-engineering
description: >
  Use this skill when building with Claude API, Anthropic SDK, or managed agents. Covers model selection, cost-conscious patterns, token budgeting, batch processing, prompt caching, and cost tracking for LLM-driven applications.
---

# Agentic engineering

Build with Claude API and managed agents. Focus: cost awareness, right-size models, sustainable LLM workflows.

## Model selection

Pick by task complexity, cost, and latency. Model names, prices, and discount rates change — verify current details in official Anthropic docs before quoting costs or hard-coding model IDs.

| Tier | Best for | Trade-off |
|------|----------|-----------|
| **Largest reasoning model** | Complex reasoning, multi-step planning, code generation, research synthesis | Highest quality, highest cost and latency |
| **Balanced model** | Most LLM tasks, general purpose work, fast iteration | Strong default for quality and cost |
| **Fast model** | Simple tasks, high-volume processing, real-time responses | Lowest latency and cost, weaker on complex work |

### Selection heuristics

- **Use the fast model** for: bulk text classification, simple summaries, content filtering, high-frequency tasks (chatbots, API responses)
- **Use the balanced model** for: default — feature work, debugging, code review, most agent tasks
- **Use the largest reasoning model** when the balanced model fails or the task needs deep reasoning — multi-doc synthesis, architectural decisions, complex proofs

### Cost-quality trade-off

Test on the fastest suitable model first. Underperforms → upgrade to the balanced model. Only use the largest reasoning model if the balanced model consistently fails.

```python
# Example: classify sentiment
def classify_sentiment(text: str) -> str:
    response = client.messages.create(
        model="claude-haiku-4-5",  # verify current model ID before shipping
        max_tokens=50,
        messages=[
            {
                "role": "user",
                "content": f"Classify sentiment: {text}. Reply: positive, negative, or neutral."
            }
        ]
    )
    return response.content[0].text
```

## Token budgeting

Tokens = cost unit. Manage three categories:

### Input tokens (cheaper)

- Every prompt word costs
- Long contexts (system prompts, documents, examples) multiply input cost
- Caching: repeat inputs amortise cost over time

### Output tokens (more expensive)

- Longer responses cost more
- Step-by-step reasoning uses 2–3× more tokens than direct answers
- Use `max_tokens` to cap runaway outputs

### Batch processing

Use batch API for non-urgent work:
- Bulk classification or summaries
- Reports, analysis, content generation
- Lower throughput, ~24-hour processing window
- Discount rate changes over time — verify current pricing before estimating savings

```python
# Batch request format
batch_input_file_id = client.beta.files.upload(
    file=open("requests.jsonl", "rb"),
).id

batch = client.beta.messages.batches.create(
    requests=[
        {
            "custom_id": "request-1",
            "params": {
                "model": "claude-sonnet-4-6",
                "max_tokens": 1024,
                "messages": [{"role": "user", "content": "Classify: ..."}],
            },
        },
        # ... more requests
    ],
)
```

## Prompt caching

Cache static content (docs, examples, system prompts) across requests. Cache hits are cheaper and faster than resending the same large context, but exact rates change — verify current pricing before promising savings.

```python
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    system=[
        {
            "type": "text",
            "text": "You are a code reviewer...",  # repeated, high value
            "cache_control": {"type": "ephemeral"}
        }
    ],
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": "Here's the code to review:",
                    "cache_control": {"type": "ephemeral"}
                },
                {"type": "text", "text": code_snippet}
            ]
        }
    ]
)
```

Monitor `usage.cache_read_input_tokens` vs `usage.input_tokens`. Healthy ratio: >30% cache reads on repeated tasks.

## Cost tracking

Log cost per request:

```python
def log_usage(response) -> None:
    usage = response.usage

    print(
        "Model: {model}; input: {input}; cache read: {cache}; output: {output}".format(
            model=response.model,
            input=usage.input_tokens,
            cache=getattr(usage, "cache_read_input_tokens", 0),
            output=usage.output_tokens,
        )
    )
```

Aggregate usage by model, task, and time period. Calculate cost from a central pricing table that is reviewed against official docs.

## Patterns for cost efficiency

### Few-shot examples over lengthy instructions

Short concrete examples cheaper than long prose:

```python
# BAD: long explanation
system = """You are a classifier. Consider semantic meaning, context, 
domain-specific terminology, edge cases, and handle ambiguous cases 
by choosing the closest match..."""

# GOOD: examples
system = """Classify into [positive, negative, neutral].

Example:
- "Love this!" → positive
- "Terrible." → negative
- "It's fine." → neutral
"""
```

### Streaming for perceived performance

Stream tokens as they arrive. No cost reduction, but improves UX:

```python
with client.messages.stream(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "..."}],
) as stream:
    for text in stream.text_stream:
        print(text, end="", flush=True)
```

### Structured output (JSON schema)

Constrain output format to cut token waste and parsing overhead:

```python
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[...],
    response_format={
        "type": "json_schema",
        "json_schema": {
            "name": "classification",
            "schema": {
                "type": "object",
                "properties": {
                    "label": {"type": "string", "enum": ["positive", "negative", "neutral"]},
                    "confidence": {"type": "number"}
                },
                "required": ["label", "confidence"]
            }
        }
    }
)
```

### Parallel batch processing over sequential loops

Process N items in one request, not N requests:

```python
# BAD: N requests for N items
for text in texts:
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=50,
        messages=[{"role": "user", "content": f"Classify: {text}"}],
    )

# GOOD: 1 request for N items
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=500,
    messages=[
        {
            "role": "user",
            "content": f"Classify each (reply in JSON):\n\n" + 
                       "\n".join(f"{i}: {text}" for i, text in enumerate(texts))
        }
    ]
)
```

## Managed agents (Claude AI + API integration)

Use managed agents for complex, long-running tasks. Agents handle tool use, looping, state automatically.

- Define task in Claude AI (UI)
- Integrate results into app via API
- Auto-retried and resumed on failure
- No orchestration token overhead (managed server-side)

Cost: pay only for actual Claude API calls (same per-token pricing).

## Monitoring & observability

- Track API usage via Anthropic Dashboard or invoice
- Alert on unexpected cost spikes
- Log token usage per task, model, user
- Publish monthly cost breakdown
- Benchmark cost per feature
