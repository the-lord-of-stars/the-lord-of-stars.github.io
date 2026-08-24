# Zefei Xie — Academic Homepage

This repository contains Zefei Xie's English academic and professional homepage, built with [al-folio](https://github.com/alshedivat/al-folio) and deployed through GitHub Pages.

## Local development

The project requires Ruby 3.3, Bundler, Node.js 20, npm, and ImageMagick.

```bash
bundle install
npm ci
bundle exec jekyll serve
```

Open `http://localhost:4000` while the development server is running.

## Production checks

```bash
npm run lint:prettier
npm run lint:style-contract
bundle exec al-folio upgrade audit --no-fail
bundle exec jekyll build
```

On Windows, also run:

```powershell
powershell -ExecutionPolicy Bypass -File test/site_content_contract.ps1
```

## Updating content

- Biography and homepage modules: `_pages/about.md`
- Experience: `_pages/experience.md`
- Publications: `_bibliography/papers.bib`
- News: `_news/`
- Projects: `_projects/`
- Public profile links: `_data/socials.yml`
- CV: replace `assets/pdf/Zefei_Xie_CV.pdf` using the same filename
- Portrait: replace `assets/img/prof_pic.jpg` using the same filename

## Deployment

Changes are developed on a feature branch and merged into `master` without rewriting history. The `Deploy site` GitHub Actions workflow builds the Jekyll site and publishes `_site` to the `gh-pages` branch. GitHub Pages must be configured to serve from `gh-pages`.

The public site is [https://the-lord-of-stars.github.io](https://the-lord-of-stars.github.io). The navigation also links to the separate personal site at [https://www.zefei.site](https://www.zefei.site).
