# UW CSE Notes - Obsidian Vault

## Note Conventions

### Linking & References
- Internal links use Obsidian wiki-links: `[[Page Name]]`
- Disambiguated links use full paths: `[[CSE451/Virtualization/Memory/Virtual Memory]]`
- Display text overrides: `[[CSE461/Definitions/Transmission Control Protocol (TCP)|TCP]]`
- Embedded images: `![[Screenshots/image.png]]`
- Cross-course references are used freely: `[[CSE351/System Programming/Exceptions]]`
- Cross-link on **first mention per section only** — not every occurrence. If a term reappears in a new section, link it again there.

### Formatting
- **Bold** for terms when first introduced: `**[[Term]]**: Definition text`
- Acronyms: full name with parenthetical, e.g. `Cyclic Redundancy Check (CRC)`
- Math: LaTeX via `$$...$$` (display) and `$...$` (inline)
- Comparison tables with aligned columns for contrasting concepts
- File names are Title Case, multi-word descriptive names

### File Organization
- Each course has an `Index.md` as the master navigation hub with links to all topics
- Each course has a `README.md` as a brief intro
- Top-level directories are major topic areas
- `*Components/` subdirectories break a complex topic into small focused files (e.g. `TrapsComponents/`, `FrameComponents/`)
- `Definitions/` directories hold one-file-per-term glossary entries (short, 1-3 sentences each)
- `Screenshots/` directories store PNG images referenced inline from notes
- **Always update the course `Index.md`** when creating, moving, renaming, or splitting any file

### Note Structure Patterns
- Hub files are short (2-10 lines) and serve as link collections to subtopics
- **Progressive Narrative Flow**: Sections within a detailed file MUST build on each other logically — like a math textbook where you cannot show calculus before addition. Apply whichever stages the content supports, in this order: core concept → mechanism/timeline → concrete walkthrough/example → physical implementation details → outcomes/trade-offs. This is a guiding principle, not a rigid template — skip stages the content doesn't warrant, but never backtrack or scatter related points.
- **Deep Technical Detail ("Not Sparknotes")**: Explanations must be thorough. Always explain the "how" and the "why" (e.g., the underlying physical storage mechanics or the algorithmic logic). **Never sacrifice technical depth for brevity. The goal is to expand and add information to the notes, never to reduce or summarize them into a shorter form.**
- **Strictly Class Notes — No New Content**: These notes reflect only what was taught in class. Do not add new topics, sub-concepts, or technical content that was not present in the source material. You may expand the "how" and "why" of existing content (e.g., explain the mechanism behind a stated fact), but do not introduce new concepts the user did not bring up. When content is terse, elaborate on what is already there — do not branch into related topics.
- **Strict Course Terminology**: Strictly adhere to the terminology used in the specific course lectures and labs (e.g., in CSE452, use **ShardMaster** and **ShardKV Group**, NOT generic industry terms like "Control Plane" or "Data Plane"). When uncertain, read existing files in that course's directory to check established terminology. If still unclear, ask the user before writing.
- **Dual-Layer Explanations**: Apply whenever there is a formal mathematical or algorithmic definition — anything involving notation, inequalities, pseudocode, or formal protocol step sequences. Skip for plain-English concepts that have no formal counterpart. Provide both a formal definition (textbook/mathematical rigor) and a simplified explanation (plain-English intuition). Do NOT use emojis for these headers; maintain professional text-only formatting.
  - *Example Format:*
    `### Formal Definition`
    `$TS(T) < WT(X)$`
    `### Simplified Explanation`
    `Someone from the future already changed it.`
- **Encapsulation & High-Density Linking**: Treat the vault as a knowledge graph.
  - **Definitions**: Only extract terms into the `Definitions/` folder if they are referenced by multiple other files. Otherwise, **inline them** within the relevant topic.
  - **Components**: Split a topic into a main file and a `*Components/` subdirectory when it has **3 or more distinct sub-concepts that each require multi-paragraph treatment**. If a sub-concept can be covered in a few sentences, keep it inline.
  - **DRY Rule**: If a concept is referenced by **2 or more other files**, extract it into its own dedicated file to avoid repetition. Do not repeat the same explanation across multiple files — link to the single source of truth instead.
  - **No God Files**: Avoid files that try to cover everything. A file that grows excessively large should be split. Avoid 3+ levels of nesting within a file's content structure.
  - Extensively cross-link terms using full disambiguated paths on first mention per section.
- **Robust Mermaid Diagrams**: Add a diagram whenever it would meaningfully clarify the content — especially flows, timelines, state machines, and protocol sequences. **Always add a diagram when the file has no PNG screenshots**, as a substitute for the lecture slide visual. Use Obsidian-compatible syntax:
  - Use `-->|label|` or `==>|label|` for labeled arrows.
  - **Avoid leading numbers followed by a period** in labels (e.g., use `(1) Step` instead of `1. Step`) to prevent the renderer from misinterpreting them as markdown lists.
  - Prefer the `subgraph ID [Title]` syntax for clarity and compatibility.
- Personal annotations appear as `Me: ...` comments
- Source attributions at bottom (e.g. OSTEP textbook references)
- Related/See-also sections at the end linking to dependencies
- **Industry Standard Terms**: At the bottom of each file, include a section mapping course-specific terminology to industry-standard equivalents (e.g., "ShardMaster" → "Configuration Service / Control Plane"). This helps bridge class concepts to real-world usage.

### Directory Hierarchy Pattern
- Flat files for simple topics
- Nested `*Components/` subdirectories when a topic has many sub-concepts
- Depth varies by complexity (2-5 levels), but wiki-links allow non-hierarchical navigation

### Anki Card Conventions
- Only generate Anki cards when **explicitly asked** — do not add them by default.
- **Front**: Always use "Why" or "What happens when" questions to test mechanism reasoning rather than rote definition (e.g., "Why three steps instead of two" instead of "What is a three-way handshake").
- **Back**: Keep it to 3–5 sentences. If it's longer, it's memorization, not understanding.
- **Process**: Write the back in your own words from memory, then verify against notes. Never copy-paste.
- **Trip Wires**: Add a dedicated line for common wrong answers or misconceptions (e.g., "Common wrong answer: TIME_WAIT is a bug—it is actually intentional and necessary").

*Example Card:*
- **Front**: Why does TCP use a three-way handshake instead of two steps?
- **Back**: Two steps only confirms one direction. The client sends SYN (proposes its ISN), server replies SYN-ACK (confirms client's ISN and proposes its own), client sends final ACK (confirms server's ISN). Both sides must confirm the other's ISN was received — a two-way exchange leaves the server never knowing if its ISN was acknowledged.

## When Creating or Organizing Notes

The user often dumps raw lecture content into files without structure, or asks for a new note to be created from scratch. Both cases follow the same process:

1. **Fix grammar and typos** throughout
2. **Add a `# Course: Topic` title heading** to every file (e.g. `# SQL: Joins`)
3. **Add `[[]]` cross-links** between related files — link to specific headings when possible (e.g. `[[Aggregates#GROUP BY]]`). Link on first mention per section only.
4. **Bold terms** on first introduction
5. **Delete empty or near-empty files** (stubs with only 1-2 lines of no real content)
6. **Consolidate redundant files** — if two files cover the same topic, merge them
7. **Move loose images** into a `Screenshots/` subdirectory
8. **Add a Related section** at the bottom of files that connect to other topics
9. **Fix flow and logical ordering** — sections within a file must build on each other like a math textbook. Eliminate backtracking and scattered thoughts.
10. **Never remove information to make a file shorter** — the goal is better organization, not brevity. Always prioritize expanding and adding information over reduction. Expand on points that are terse or unclear using only what is already in the notes.
11. **Preserve the user's original content and meaning** — reorganize and clean up, but do not add new topics or sub-concepts that were not in the source material. These are strictly class notes.
12. **Add cross-course links** — check whether topics in other courses cover the same concept in more depth and link to them using disambiguated paths.
13. **Rename files to Title Case** if they aren't already
14. **Split large files into focused files (Encapsulation)** — split when a topic has 3+ distinct sub-concepts each requiring multi-paragraph treatment, or when 3+ other files reference the same concept (DRY). Do not over-encapsulate: if a concept is minor or highly context-dependent, inline it.
15. **Enforce Professional Style** — strictly remove any emojis from headers and content. Use plain markdown for structure.
16. **Infer file path and name** when creating from scratch — match the existing course directory structure. If the correct path is ambiguous, ask the user before writing.
17. **Update `Index.md`** — always update the course Index.md to include any newly created, moved, or renamed file.
18. **Add Industry Standard Terms section** — at the bottom of each file, map course-specific terms to their industry-standard equivalents.
