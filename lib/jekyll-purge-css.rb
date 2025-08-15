# frozen_string_literal: true

require "jekyll"
require_relative "jekyll-purge-css/version"

module Jekyll
  # PurgeCSS Hook
  module PurgeCss
    class Error < StandardError; end

    Jekyll::Hooks.register :site, :post_write do |site|
      @config = site.config["PurgeCSS"] || raise(Error, "PurgeCSS config not found")
      @content_dirs = @config["content"] || raise(Error, "Content list not found")
      @css_dirs = @config["css"] || raise(Error, "CSS list not found")
      @exclude = @config["exclude"] || []
      @output_dir = @config["output"] || "."

      puts "[Jekyll PurgeCSS] Running PurgeCSS..."
      puts "[Jekyll PurgeCSS] Checking PurgeCSS version"
      system("purgecss", "--version")

      @css_dirs.each do |css_pattern|
        Dir.glob(css_pattern).each do |path|
          next unless File.file?(path)

          file = File.basename(path)

          skip = @exclude.any? do |exclusion|
            file == exclusion || file.match?(Regexp.new(exclusion))
          end
          next if skip

          puts "[Jekyll PurgeCSS] Processing: #{file}"
          system("purgecss",
                 "--css", path,
                 "--content", *@content_dirs,
                 "--output", @output_dir)
        end
      end

      puts "[Jekyll PurgeCSS] Finished."
    end
  end
end
