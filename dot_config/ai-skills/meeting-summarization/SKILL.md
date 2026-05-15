---
name: "meeting-summarization"
description: "Summarize VTT meeting transcripts into structured markdown. Use when asked to read, summarize, or extract insights from .vtt WebVTT transcript files, or when invoked to auto-discover and summarize unsummarized transcripts. Produces per-meeting summaries with discussion topics, technical decisions, action items, and customer sentiment analysis."
compatibility: "No external dependencies required"
metadata:
  author: "Marc Henry de Frahan <mhenrydefrah@nvidia.com>"
  version: "1.0"
  tags:
    - meetings
    - transcripts
    - vtt
    - summarization
    - action-items
    - sentiment-analysis
  languages:
    - markdown
  domain: "documentation"
---

# Meeting Transcript Summarization

## When to activate

- User asks to summarize a `.vtt` transcript
- User asks for meeting notes, action items, or sentiment analysis from a discussion
- User invokes this skill without specifying files (auto-discover mode)

## Step-by-step instructions

### 0. Discover unsummarized transcripts

When no specific files are provided, scan the working directory (and common subdirectories like `meetings/`) for `.vtt` files. For each `discussion-YYYYMMDD.vtt` found, check whether a corresponding `summary-YYYYMMDD.md` exists in the same directory. Only process transcripts that do not yet have a summary. Report which files were found, which already have summaries, and which will be processed.

### 1. Read the transcript in chunks

VTT files are typically 5,000–10,000+ lines. Read ~400 lines per chunk using offset/limit. Spread reads across the file (beginning, middle, end) to capture all topics. Read at least 4–5 chunks per file.

### 2. Extract key information

From the `<v Name>` tags and dialogue, identify:

- **Participants** — full names from speaker tags
- **Topics** — major agenda items and discussion threads
- **Decisions** — any conclusions reached or approaches agreed upon
- **Open questions** — unresolved concerns or items deferred
- **Action items** — tasks assigned to specific people

### 3. Write the summary file

Create `summary-YYYYMMDD.md` in the same directory as the transcript, matching its date. Use the output format below.

### 4. Multiple files

When processing multiple transcripts, complete one fully (read + write) before starting the next.

## Output format

```markdown
# Meeting Summary: Mon DD, YYYY

**Participants:** Name1, Name2, Name3

---

## 1. First Topic

**Subtopic:** Brief description.

- Key detail or decision
- Technical insight with correct terminology

---

## 2. Second Topic

...

---

## N. Customer Sentiment Analysis

**Overall Sentiment:** One-line assessment

**Engagement Level:** How actively participants engaged

**Pain Points Identified:**
- Concern or frustration raised

**Receptiveness to Solutions:**
- How open the team is to proposed approaches

**Confidence Level:** Team confidence in current path

**Relationship Health:** State of the working relationship

---

## Action Items / Next Steps

- **Person:** Task description
```

## Edge cases

- **Overlapping timestamps**: VTT files often have interleaved speaker segments. Reconstruct the dialogue flow by timestamp order, not line order.
- **Unnamed speakers**: Transcripts may use `@1` or similar for unidentified participants. Note them as unnamed or infer from context if possible.
- **Truncated reads**: If a chunk ends mid-topic, the next chunk will pick up context. Don't assume a topic ended just because a chunk boundary was reached.
- **Transcription errors**: VTT auto-transcription may garble technical terms (e.g., "rostering" for "raw string", "frog" for "prog"). Use surrounding context to interpret correctly.

## Technical vocabulary

Use precise terms when they appear in discussion:

- NVRTC, JIT, PTX, fatbin, CUDA graphs
- CUB, Thrust, transform_reduce, DeviceSegmentedReduce
- void*, type erasure, shared memory, coalescing
- Loci-specific: rules, sequences, intervals, maps, multimaps, preprocessor
