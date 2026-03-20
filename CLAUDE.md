# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Quarto-based course website** for Central South University (CSU) bioinformatics courses. It uses a multi-project architecture where each course is an independent Quarto website that gets built separately and merged into a single site.

- **Live URL**: https://wanglabcsu.github.io/courses/
- **Course content**: Quarto markdown files (`.qmd`) with executable R code
- **Build output**: `_site/` directory (deployed to GitHub Pages)

## Build Commands

### Build Everything
```bash
./build.sh
```
This script:
1. Auto-discovers all course directories (subdirs containing `_quarto.yml`)
2. Renders root directory (main website)
3. Renders each course independently with its own config
4. Merges all outputs into `_site/`

### Build Single Directory
```bash
# Root only
quarto render

# Specific course
cd r-and-rmarkdown && quarto render
```

### Preview Locally
```bash
cd _site && python3 -m http.server 8000
```

### Deploy to Lab Server
```bash
./build.sh
./sync-to-server.sh  # rsync to lab-bio server
```

## Critical Architecture: Multi-Project Build

The repository uses **independent builds per course** to ensure each course has its own navbar/sidebar configuration.

### Root `_quarto.yml` Key Config
```yaml
render:
  - "*.qmd"
  - "!*/**"  # Excludes all subdirectories - critical!
```

The `- "!*/**"` exclusion is essential:
- Without it: root `quarto render` recursively renders subdirs with root config
- This causes sub-course menus to be overwritten/incorrect

### Build Flow
1. Root renders independently (produces `index.html`, etc.)
2. Each subdir with `_quarto.yml` renders independently
3. `build.sh` copies all `_site/` contents into root `_site/`

## Critical Link Rules

Due to the multi-project architecture, links must follow specific rules:

| From | To | Format |
|------|-----|--------|
| Root | Sub-course | `r-and-rmarkdown/index.html` (.html required) |
| Sub-course | Root | `../index.html` (.html required) |
| Sub-course | Sub-course (same) | `syllabus.qmd` (.qmd auto-converted) |
| Any | Slide | `slides/slides-name.html` (.html required) |

**Common Bug**: Using `.qmd` in root-to-sub links causes file download instead of page navigation.

## Adding a New Course

1. Create directory with kebab-case name: `mkdir new-course`
2. Create `_quarto.yml` (copy from existing course, update title/paths)
3. Create standard files: `index.qmd`, `syllabus.qmd`, `resources.qmd`, `license.qmd`
4. Create subdirs: `styles/`, `lectures/`, `labs/`, `slides/`, `data/`
5. Add to root `index.qmd` course list (use `.html` link)
6. Add to root `_quarto.yml` navbar (use `.html` link)

No changes needed to `build.sh` - it auto-discovers courses by finding `_quarto.yml` files.

## Code Block Conventions

### Executable R Code (for labs)
```markdown
```{r}
#| eval: true
#| echo: true
result <- mean(c(1, 2, 3))
```
```

### Example/Syntax Display (not executed)
Use 4 backticks + double braces:
```markdown
````markdown
```{r chunk-name, echo=TRUE}
# Example code shown but not run
```
````
```

### Answer Keys
Wrap in `<details>` tags:
```markdown
<details>
<summary>点击查看参考答案</summary>
```{r}
# Answer code here
```
</details>
```

## Key References

- **Detailed content standards**: See `AGENTS.md`
- **Naming conventions**: kebab-case for dirs/files (e.g., `r-and-rmarkdown/`)
- **Colors**: CSU red `#8B0000`, gold `#C5B358`
- **Required R packages**: rmarkdown, knitr, showtext, tidyverse, DT, reticulate
- **Slide logo path**: `../../logo/csu_logo.png`
