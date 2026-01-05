# Agent Instructions

## Building and Running the Application

This project uses Jekyll. A Dockerfile is provided for easy local development.

### Using Docker

The easiest way to run the application is using the provided script:

1. **Run with default port (4000):**
   ```bash
   ./start-dev.sh
   ```

2. **Run with a custom port:**
   ```bash
   ./start-dev.sh --port 8080
   ```

This script handles building the image and running the container with the correct volume mounts.

### Local Environment (without Docker)

If you need to run it directly on the machine:

1. Ensure Ruby and Bundler are installed.
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Run the server:
   ```bash
   bundle exec jekyll serve --incremental
   ```

## Project Structure

- `_config.yml`: Main configuration.
- `_data/`: Data files (YAML) for resume content.
- `_layouts/` & `_includes/`: HTML templates.
- `_sass/`: CSS styles.
