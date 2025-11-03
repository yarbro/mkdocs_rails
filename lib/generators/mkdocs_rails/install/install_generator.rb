# frozen_string_literal: true

module MkdocsRails
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    class_option :vanilla,
                 type: :boolean,
                 default: false,
                 desc: "Use vanilla MkDocs instead of Material for MkDocs"

    # TODO: Make this configurable
    def create_docs_structure
      empty_directory "docs"
    end

    def copy_mkdocs_config
      if options[:vanilla]
        template "mkdocs_vanilla.yml.tt", "docs/mkdocs.yml"
        template "docs/index_vanilla.md.tt", "docs/index.md"
      else
        template "mkdocs_material.yml.tt", "docs/mkdocs.yml"
        template "docs/index_material.md.tt", "docs/index.md"
      end
    end

    def copy_package_mapping_template
      template "mkdocs-packages.tt", "docs/.mkdocs-packages"
    end

    def copy_bin_script
      template "bin/docs.tt", "bin/docs"
      chmod "bin/docs", 0o755
    end

    def show_instructions
      say "\n"
      say "MkDocs Rails installed with #{theme_name}!", :green
      say "\n"
      say "Next steps:", :yellow
      say "  1. Run setup: bin/docs setup"
      say "  2. Start docs: bin/docs serve"
      say "  3. Visit: http://localhost:8000"
      say "\n"
    end

    private

    def theme_name
      options[:vanilla] ? "MkDocs" : "Material for MkDocs"
    end

    def app_name
      Rails.application.class.module_parent_name
    end
  end
end
