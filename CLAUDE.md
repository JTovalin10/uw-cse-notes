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
- Detailed files use consistent heading patterns:
  - CSE461 style: `# [Layer]: [Topic]` → `## Low-Level Primer` → numbered sections → comparison tables → related topics
  - CSE451 style: `# What is it` → `# What does it do` → `# How X works` → `# Key points` → `# Components` → `# Related`
- Personal annotations appear as `Me: ...` comments
- Source attributions at bottom (e.g. OSTEP textbook references)
- Related/See-also sections at the end linking to dependencies

### Directory Hierarchy Pattern
- Flat files for simple topics
- Nested `*Components/` subdirectories when a topic has many sub-concepts
- Depth varies by complexity (2-5 levels), but wiki-links allow non-hierarchical navigation

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
9. **Fix flow and logical ordering** — sections within a file should build on each other (fundamentals first, then details, then advanced patterns)
10. **Preserve the user's original content and meaning** — reorganize and clean up, but don't add new technical content or change what was taught
11. **Rename files to Title Case** if they aren't already
12. **Split large files into focused files** when a section is a self-contained topic that could be referenced independently — these notes come from slides that cram many topics together, so break them into individual files when it makes sense for linking and lookup
