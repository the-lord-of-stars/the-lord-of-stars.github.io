# CMU Academic and Professional Homepage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the legacy Hexo site with a verified English al-folio academic and professional homepage for Zefei Xie and deploy it to `the-lord-of-stars/the-lord-of-stars.github.io`.

**Architecture:** Import the al-folio v1.x starter into the existing repository without rewriting its history, then personalize only starter-owned configuration, content collections, bibliography data, and site assets. Preserve al-folio's plugin-owned runtime and GitHub Actions deployment model.

**Tech Stack:** Jekyll, al-folio v1.x Ruby gems, Liquid, YAML, BibTeX, npm/Prettier, GitHub Actions, GitHub Pages

**Spec:** `docs/superpowers/specs/2026-08-24-cmu-academic-homepage-design.md`

## Global Constraints

- English only; academic-plus-employment narrative.
- Preserve Git history; never force-push.
- Do not modify `D:\Work\project\display-web` or `https://www.zefei.site`.
- Publish no phone number or official CMU seal.
- Customize `_config.yml`, `_data`, `_pages`, `_projects`, `_news`, `_bibliography`, and site assets; do not create runtime overrides.
- Keep light/dark modes; omit Blog, Teaching, Awards, Service, comments, Live2D, canvas effects, and decorative motion.

## File Map

- `_config.yml`: identity, root URL, metadata, feature flags.
- `_data/socials.yml`: approved public links.
- `_pages/about.md`: homepage biography and modules.
- `_pages/publications.md`, `_pages/experience.md`, `_pages/projects.md`, `_pages/cv.md`, `_pages/personal-site.md`: navigation routes.
- `_bibliography/papers.bib`: two verified publications.
- `_news/*.md`: dated milestones.
- `_projects/*.md`: selected projects.
- `assets/img/prof_pic.jpg`, `assets/pdf/Zefei_Xie_CV.pdf`: approved public assets.
- `test/site_content_contract.ps1`: identity, privacy, content, and asset checks.
- `README.md`: maintenance and deployment guide.

---

### Task 1: Import al-folio While Preserving History

**Files:**

- Replace: legacy Hexo site files
- Import: starter files from `upstream/main`
- Preserve: `docs/superpowers/**`

**Interfaces:**

- Consumes: fetched `upstream/main`
- Produces: al-folio starter on `codex/cmu-academic-homepage`, descended from `origin/master`

- [ ] **Step 1: Record safety state**

Run `git status --short --branch`, `git log -3 --oneline --decorate`, and `git remote -v`; expect a clean feature branch with distinct `origin` and `upstream`.

- [ ] **Step 2: Remove only enumerated Hexo paths**

Remove tracked `source`, `scaffolds`, `themes/particlex`, `_config.landscape.yml`, legacy package files, and `.idea`; preserve `.git` and `docs/superpowers`.

- [ ] **Step 3: Import the upstream snapshot**

Use `git archive upstream/main` and extract it at the repository root. Expect `Gemfile`, `_config.yml`, `_pages`, `_data`, `_bibliography`, `_projects`, `_news`, `assets`, and `.github/workflows`.

- [ ] **Step 4: Commit**

Run `git add -A` and `git commit -m "build: replace legacy site with al-folio"`.

---

### Task 2: Configure Identity, Navigation, Privacy, and Routes

**Files:**

- Modify: `_config.yml`, `_data/socials.yml`, `_pages/about.md`, `_pages/publications.md`, `_pages/projects.md`, `_pages/cv.md`, `_pages/404.md`
- Create: `_pages/experience.md`, `_pages/personal-site.md`, `test/site_content_contract.ps1`

**Interfaces:**

- Produces: `/`, `/publications/`, `/experience/`, `/projects/`, `/cv/`, and external `Personal Site`

- [ ] **Step 1: Write the failing contract**

Create a PowerShell test that requires `first_name: Zefei`, `last_name: Xie`, `url: https://the-lord-of-stars.github.io`, blank `baseurl`, the six agreed navigation items, and zero occurrences of `(626) 944-1861`.

- [ ] **Step 2: Verify failure**

Run `powershell -ExecutionPolicy Bypass -File test/site_content_contract.ps1`; expect failure on template values.

- [ ] **Step 3: Personalize configuration**

Set exact identity/root URL, concise academic metadata, dark mode, Open Graph, Schema.org, selected publications, and safe external links. Disable search, posts, comments, newsletter, analytics, and unused integrations.

- [ ] **Step 4: Create navigation and public socials**

Order About 1, Publications 2, Experience 3, Projects 4, CV 5, Personal Site 6. Keep only `zefeix@andrew.cmu.edu`, GitHub `the-lord-of-stars`, the known LinkedIn URL, the CV, and `https://www.zefei.site`.

- [ ] **Step 5: Verify and commit**

Run the contract; expect PASS. Commit with `git commit -m "feat: configure academic site identity and navigation"`.

---

### Task 3: Add Academic and Professional Content

**Files:**

- Modify: `_pages/about.md`, `_pages/experience.md`, `_bibliography/papers.bib`
- Replace: `_news/*.md`, `_projects/*.md`
- Modify: `test/site_content_contract.ps1`

**Interfaces:**

- Consumes: supplied CV, existing site, verified public links
- Produces: biography, research interests, two papers, three experiences, news, and three projects

- [ ] **Step 1: Extend the failing contract**

Require `AwesomeLit`, `What Happened to Automated Visualization?`, `Zhejiang Dahua Technology`, `NetEase Hangzhou Research Institute`, `IBM Watsonx`, `70%`, `67 peak concurrent users`, and `Top 5`; run and expect failure.

- [ ] **Step 2: Write homepage and experience copy**

Use first-person English focused on agentic AI, LLM systems, RAG, human-AI collaboration, data analysis/visualization, reliability, and transparency. Present CMU MIIS as current and Nottingham BSc as completed.

- [ ] **Step 3: Populate verified bibliography**

Create two valid BibTeX entries with verified authors, title, venue, year, DOI/paper URL, code/project URLs, and `selected = {true}`.

- [ ] **Step 4: Populate news and projects**

Create concise, dated records for AwesomeLit, AgenticInsight, and IBM Watsonx, retaining verified quantitative outcomes.

- [ ] **Step 5: Remove template-person content**

Run `rg -n "Albert Einstein|You R\. Name|example_pdf|555 your office|Inspire HEP" _config.yml _data _pages _news _projects _bibliography assets`; expect no published-content matches.

- [ ] **Step 6: Verify and commit**

Run the contract; expect PASS. Commit with `git commit -m "content: add research experience and selected work"`.

---

### Task 4: Add Approved Assets and Documentation

**Files:**

- Create: `assets/img/prof_pic.jpg`, `assets/pdf/Zefei_Xie_CV.pdf`
- Modify: `_config.yml`, `_pages/about.md`, `_data/socials.yml`, `README.md`, `test/site_content_contract.ps1`

**Interfaces:**

- Consumes: supplied JPG and PDF
- Produces: stable public portrait/CV paths and maintenance guide

- [ ] **Step 1: Add failing asset checks**

Require both files, portrait/CV references, and enabled Open Graph/Schema.org metadata; run and expect failure.

- [ ] **Step 2: Copy only approved assets**

Copy the supplied portrait byte-for-byte to `assets/img/prof_pic.jpg` and CV to `assets/pdf/Zefei_Xie_CV.pdf`. Configure non-circular right alignment on desktop and responsive placement on mobile without changing appearance.

- [ ] **Step 3: Configure metadata**

Use the portrait as Open Graph image and connect the CV page/social link.

- [ ] **Step 4: Replace README**

Document prerequisites, install/build/serve commands, content update paths, branch strategy, and GitHub Pages deployment.

- [ ] **Step 5: Verify and commit**

Run the contract; expect PASS. Commit with `git commit -m "feat: add profile assets and site documentation"`.

---

### Task 5: Validate Production Quality

**Files:**

- Modify only files implicated by failures
- Test: generated `_site/`

**Interfaces:**

- Produces: locally verified production site

- [ ] **Step 1: Install locked dependencies**

Run `bundle install` and `npm ci`; expect successful locked installs.

- [ ] **Step 2: Run static validation**

Run `npm run lint:prettier`, `npm run lint:style-contract`, `bundle exec al-folio upgrade audit --no-fail`, and the PowerShell content contract; expect success.

- [ ] **Step 3: Build root site**

Run `bundle exec jekyll build`; expect `_site` with no Liquid, YAML, or BibTeX errors.

- [ ] **Step 4: Check generated site**

Verify required routes/assets and run the repository's broken-link validation against `_site`; expect no missing internal links, portrait, CV, template identity, or phone number.

- [ ] **Step 5: Browser QA**

Serve locally and inspect desktop/mobile widths, navbar order, portrait crop, About, News, publications, projects, Experience, dark mode, CV, Personal Site link, and console logs.

- [ ] **Step 6: Fix evidenced defects and re-verify**

Rerun the smallest affected check after each fix, then the full static suite and build. Commit only actual fixes with `git commit -m "fix: resolve production validation findings"`.

---

### Task 6: Review, Publish, and Verify Deployment

**Files:**

- No planned source changes

**Interfaces:**

- Produces: deployed GitHub Pages site with recovery point

- [ ] **Step 1: Final clean verification**

Run content contract, Prettier, style contract, al-folio audit, and production build; require a clean worktree.

- [ ] **Step 2: Review against origin**

Run `git diff --stat origin/master...HEAD`, `git diff --name-status origin/master...HEAD`, and `git log --oneline origin/master..HEAD`; confirm only planned files.

- [ ] **Step 3: Request action-time publication approval**

Report the exact commits and that portrait, CV, CMU email, education, work history, publications, and profile links will become public.

- [ ] **Step 4: Push without rewriting history**

After approval, push and integrate using normal Git operations; never use `--force`.

- [ ] **Step 5: Verify Actions and production**

Confirm `Deploy site`, the `gh-pages` source, and `https://the-lord-of-stars.github.io`; test representative routes, mobile layout, CV, socials, and `Personal Site` → `https://www.zefei.site`.

- [ ] **Step 6: Report evidence and recovery point**

Provide production URL, deployed commit, workflow result, validations, and previous `origin/master` commit for normal revert.
