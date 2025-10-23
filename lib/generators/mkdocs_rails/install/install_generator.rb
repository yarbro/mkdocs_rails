# frozen_string_literal: true

require "rails/generators"

module MkdocsRails
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    class_option :theme,
                 type: :string,
                 default: "material",
                 desc: "MkDocs theme to use (material or mkdocs)"

    class_option :vanilla,
                 type: :boolean,
                 default: false,
                 desc: "Use vanilla MkDocs instead of Material"

    def create_docs_directory
      empty_directory "docs/docs"
    end

    def update_gitignore
      append_to_file ".gitignore", "\n# MkDocs Python virtual environment\n.python-venv/\n"
    end

    def copy_mkdocs_config
      if use_material?
        template "mkdocs_material.yml.tt", "docs/mkdocs.yml"
        template "docs/index_material.md.tt", "docs/docs/index.md"
      else
        template "mkdocs_vanilla.yml.tt", "docs/mkdocs.yml"
        template "docs/index_vanilla.md.tt", "docs/docs/index.md"
      end
    end

    def copy_bin_script
      template "bin/docs.tt", "bin/docs"
      chmod "bin/docs", 0o755
    end

    def create_initializer
      template "mkdocs_rails.rb.tt", "config/initializers/mkdocs_rails.rb"
    end

    def add_route
      route "  constraints subdomain: 'docs' do\n    mount MkdocsRails::Engine, at: '/'\n  end"
    end

    def show_instructions
      say "\n"
      say "MkDocs Rails installed with #{theme_name}!", :green
      say "\n"
      say "Next steps:", :yellow
      say "  1. Run setup: bin/docs setup"
      say "  2. Start docs server: bin/docs serve"
      say "  3. Start Rails: rails server"
      say "  4. Visit: http://docs.lvh.me:3000"
      say "\n"
      say "Note: MkDocs Rails uses a subdomain (docs.lvh.me:3000)", :cyan
      say "\n"
    end

    private

    def use_material?
      !options[:vanilla] && (options[:theme] == "material")
    end

    def theme_name
      use_material? ? "Material for MkDocs" : "MkDocs"
    end

    def pip_packages
      use_material? ? "mkdocs-material" : "mkdocs"
    end

    def app_name
      Rails.application.class.module_parent_name
    end
  end
end
