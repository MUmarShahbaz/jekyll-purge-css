# frozen_string_literal: true

require "jekyll"
require_relative "jekyll-purge-css/version"

module Jekyll
  # PurgeCSS Hook
  module PurgeCss
    class Error < StandardError; end

    Jekyll::Hooks.register :site, :post_write do |site|
      # Get Config & Ignore option
      @config        = site.config["PurgeCSS"] || raise(Error, "PurgeCSS config not found") # Config is compulsory
      @ignore        = @config["ignore"]       || false

      # Get Remaining Config
      @content_dirs  = @config["content"]      || ( # Content is compulsory
                                                   raise(Error, "Content list not found") unless @ignore)
      @css_dirs      = @config["css"]          || ( # CSS is compulsory
                                                   raise(Error, "CSS list not found") unless @ignore)
      @exclude       = @config["exclude"]      || []
      @output_dir    = @config["output"]       || "."

      puts "[Jekyll PurgeCSS] Running PurgeCSS..."
      puts "[Jekyll PurgeCSS] Checking PurgeCSS"
      purge_css = system("purgecss", "--version", out: File::NULL, err: File::NULL)

      if purge_css
        puts "[Jekyll PurgeCSS] PurgeCSS found"
      else
        puts "[Jekyll PurgeCSS] PurgeCSS not found"
        raise(Error, "PurgeCSS not installed") unless @ignore
      end

      @css_dirs.each do |css_pattern|
        purge_all(css_pattern)
      end

      puts "[Jekyll PurgeCSS] Finished."
    end

    def purge_all(pattern)
      Dir.glob(pattern).each do |path|
        next unless File.file?(path)

        file = File.basename(path)
        skip = @exclude.any? do |exclusion|
          file == exclusion || file.match?(Regexp.new(exclusion))
        end
        next if skip

        purge_this(path)
      end
    end

    def purge_this(path)
      puts "[Jekyll PurgeCSS] Processing: #{path}"
      run = system("purgecss",
                   "--css", path,
                   "--content", *@content_dirs,
                   "--output", @output_dir,
                   out: File::NULL, err: File::NULL)
      if run
        puts "[Jekyll PurgeCSS] Successfully purged file"
      else
        puts "[Jekyll PurgeCSS] Failed to purge"
        raise(Error, "Failed to purge #{path}") unless @ignore
      end
    end

    module_function :purge_all
    module_function :purge_this
  end
end
