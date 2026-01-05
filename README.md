# Bruno Volpato Resume

:page_facing_up::briefcase: Bruno's resume.

Please check the resume [here](https://bvolpato.github.io).


# Local Development

## Using Docker (Recommended)

You can use the provided helper script to build and run the site:

```bash
./start-dev.sh
```

To run on a specific port (default is 4000):

```bash
./start-dev.sh --port 8080
```

The site will be available at `http://localhost:<PORT>`. Changes to files will be automatically detected.

## Manual Setup

Based on Jekyll. Content lives in `_data/` (experience, education, skills, recognitions) and templates under `_layouts/` and `_includes/`.

To run locally:
1. Clone the repo
2. `bundle install`
3. `bundle exec jekyll serve --incremental`
4. Open your browser to `http://localhost:4000`
