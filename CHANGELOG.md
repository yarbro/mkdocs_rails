# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-11-03

### Added
- Initial stable release
- Rails generator for creating a full MkDocs documentation structure
- Support for both **Material for MkDocs** and vanilla MkDocs themes
- Automatic creation and management of a local Python virtual environment
- Plugin auto-detection and installation from `docs/mkdocs.yml`
- Custom plugin mappings via `docs/.mkdocs-packages`
- `bin/docs` helper script with the following commands:
  - `setup` – sets up the Python environment and installs dependencies
  - `serve` – starts the MkDocs development server
  - `publish` – builds and outputs static docs to `public/docs` for Rails serving
  - `clean` – removes the published documentation files from `public/docs`

[1.0.0]: https://github.com/yarbro/mkdocs_rails/releases/tag/v1.0.0
