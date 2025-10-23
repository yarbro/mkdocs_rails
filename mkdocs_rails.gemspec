# frozen_string_literal: true

require_relative "lib/mkdocs_rails/version"

Gem::Specification.new do |spec|
  spec.name = "mkdocs_rails"
  spec.version = MkdocsRails::VERSION
  spec.authors = ["David Yarbro"]
  spec.email = ["david@yarb.ro"]

  spec.summary = "MkDocs integration for Rails applications"
  spec.description = "Integrate beautiful MkDocs documentation into your Rails app with Material theme"
  spec.homepage = "https://github.com/yarbro/mkdocs_rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yarbro/mkdocs_rails"
  spec.metadata["changelog_uri"] = "https://github.com/yarbro/mkdocs_rails/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"
end
