# UW CSE Notes - Obsidian Vault

## Note Conventions

### Linking & References
- Internal links use Obsidian wiki-links: `[[Page Name]]`
- Disambiguated links use full paths: `[[CSE451/Virtual Memory/Virtual Memory]]`
- Display text overrides: `[[CSE461/Definitions/Transmission Control Protocol (TCP)|TCP]]`
- Embedded images: `![[Screenshots/image.png]]`
- Cross-course references are used freely: `[[CSE351/System Programming/Exceptions]]`

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

### Note Structure Patterns
- Hub files are short (2-10 lines) and serve as link collections to subtopics
- **Progressive Narrative Flow**: Sections within a detailed file MUST build on each other logically. Start with the core concept, move to the mechanism/timeline, provide a concrete walkthrough/example, delve into physical implementation details, and conclude with outcomes/trade-offs. Do not scatter related points.
- **Deep Technical Detail ("Not Sparknotes")**: Explanations must be thorough. Always explain the "how" and the "why" (e.g., the underlying physical storage mechanics or the algorithmic logic).
- **Dual-Layer Explanations**: For complex rules and definitions, provide both a formal definition (textbook/mathematical rigor) and a simplified explanation (plain-English intuition). Do NOT use emojis for these headers; maintain professional text-only formatting.
  - *Example Format:*
    `### Formal Definition`
    `$TS(T) < WT(X)$`
    `### Simplified Explanation`
    `Someone from the future already changed it.`
- **Encapsulation & High-Density Linking**: Treat the vault as a knowledge graph. Extract *distinct, reusable* technical terms into the `Definitions/` folder. Extract shared concepts into their own focused files. Extensively cross-link these terms using full disambiguated paths every time they are mentioned.
  - *Example Link:* `This leads to a [[CSE444/Definitions/Dirty Read|Dirty Read]].`
  - **Crucial Limit**: Do NOT create files just for the sake of creating files. If a concept is minor, highly specific to the current topic, or only a sentence long and unlikely to be referenced elsewhere, just **inline it** in the main file. Only encapsulate concepts that are truly standalone or shared.
- Personal annotations appear as `Me: ...` comments
- Source attributions at bottom (e.g. OSTEP textbook references)
- Related/See-also sections at the end linking to dependencies

### Directory Hierarchy Pattern
- Flat files for simple topics
- Nested `*Components/` subdirectories when a topic has many sub-concepts
- Depth varies by complexity (2-5 levels), but wiki-links allow non-hierarchical navigation

### Anki Card Conventions
- **Front**: Always use "Why" or "What happens when" questions to test mechanism reasoning rather than rote definition (e.g., "Why three steps instead of two" instead of "What is a three-way handshake").
- **Back**: Keep it to 3–5 sentences. If it's longer, it's memorization, not understanding.
- **Process**: Write the back in your own words from memory, then verify against notes. Never copy-paste.
- **Trip Wires**: Add a dedicated line for common wrong answers or misconceptions (e.g., "Common wrong answer: TIME_WAIT is a bug—it is actually intentional and necessary").

*Example Card:*
- **Front**: Why does TCP use a three-way handshake instead of two steps?
- **Back**: Two steps only confirms one direction. The client sends SYN (proposes its ISN), server replies SYN-ACK (confirms client's ISN and proposes its own), client sends final ACK (confirms server's ISN). Both sides must confirm the other's ISN was received — a two-way exchange leaves the server never knowing if its ISN was acknowledged.

## When Organizing Notes

The user often dumps raw lecture content into files without structure. When asked to organize:

1. **Fix grammar and typos** throughout
2. **Add a `# Course: Topic` title heading** to every file (e.g. `# SQL: Joins`)
3. **Add `[[]]` cross-links** between related files — link to specific headings when possible (e.g. `[[Aggregates#GROUP BY]]`)
4. **Bold terms** on first introduction
5. **Delete empty or near-empty files** (stubs with only 1-2 lines of no real content)
6. **Consolidate redundant files** — if two files cover the same topic, merge them
7. **Move loose images** into a `Screenshots/` subdirectory
8. **Add a Related section** at the bottom of files that connect to other topics
9. **Fix flow and logical ordering** — sections within a file must build on each other cohesively. Eliminate backtracking and scattered thoughts.
10. **Never remove information to make a file shorter** — the goal is better organization, not brevity. Expand on points that are terse or unclear. Provide deep technical context.
11. **Preserve the user's original content and meaning** — reorganize and clean up, but don't add entirely new technical content that contradicts what was taught.
12. **Add cross-course links** — check whether topics in other courses cover the same concept in more depth and link to them using disambiguated paths.
13. **Rename files to Title Case** if they aren't already
14. **Split large files into focused files (Encapsulation)** — when a section is a heavily self-contained topic or a discrete reusable definition, break it out into its own file so it can be referenced independently. **However, do not over-encapsulate:** do not create files for the sake of creating files; if a concept is minor or highly context-dependent, inline it within the broader topic file.
15. **Enforce Professional Style** — strictly remove any emojis from headers and content. Use plain markdown for structure.
