# frozen_string_literal: true

require_relative "lib/jekyll-purge-css/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-purge-css"
  spec.version = Jekyll::PurgeCss::VERSION
  spec.authors = ["M. Umar Shahbaz"]
  spec.email = ["m.umarshahbaz.2007@gmail.com"]

  spec.summary = "Automatically remove unused CSS from Jekyll sites after build using PurgeCSS."
  spec.description = <<~DESC
    jekyll-purge-css is a Jekyll plugin that runs PurgeCSS after
    your site is built, cleaning up unused CSS based on your#{" "}
    site's content and configuration. This helps optimize your#{" "}
    site's performance and reduce CSS file size, all managed#{" "}
    seamlessly through your Jekyll configuration.
  DESC
  spec.homepage = "https://github.com/MUmarShahbaz/jekyll-purge-css"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/MUmarShahbaz/jekyll-purge-css"
  spec.metadata["changelog_uri"] = "https://github.com/MUmarShahbaz/jekyll-purge-css/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end
  spec.require_paths = ["lib"]
  spec.add_dependency "jekyll", ">= 3.0", "< 5.0"
end
