# MkDocs Rails

Easy MkDocs setup for Rails development.

## What It Does

Adds [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) (or vanilla MkDocs) to your Rails app with one command. Perfect for internal documentation, API docs, and developer guides.

## Installation

Add to your Gemfile:
```ruby
gem "mkdocs_rails", group: :development
```

Then run:
```bash
bundle install
rails generate mkdocs_rails:install
```

## Usage

```bash
# First-time setup (creates a local Python venv and installs packages)
bin/docs setup

# Start the MkDocs development server
bin/docs serve
# Visit http://localhost:8000

# Build static docs directly into Rails public/docs
bin/docs publish

# Clean the public/docs directory
bin/docs clean
```

The publish command outputs a production-ready static site to `public/docs`, automatically served by Rails at:

```bash
http://localhost:3000/docs/
```

The trailing slash (/) is required for the static docs to display correctly.

## Features

- Generator creates complete MkDocs project structure
- Material for MkDocs theme by default (or use `--vanilla` for plain MkDocs)
- Automatic Python virtual environment management
- Auto-detects and installs plugins from `mkdocs.yml`
- Simple `bin/docs` script for common tasks

## Customization

### Using Vanilla MkDocs
```bash
rails generate mkdocs_rails:install --vanilla
```

### Adding Plugins

Edit `docs/mkdocs.yml`:
```yaml
plugins:
  - search
  - awesome-pages
```

Most plugins follow the convention `mkdocs-{name}-plugin`. For custom package names, create `docs/.mkdocs-packages`:
```yaml
plugins:
  awesome-pages: mkdocs-awesome-pages-plugin
  glightbox: mkdocs-glightbox
```

Then run `bin/docs setup` to install.

## Contributing

Bug reports and pull requests are welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Added some new feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
