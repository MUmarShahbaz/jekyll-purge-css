# Jekyll PurgeCSS

Automatically remove unused CSS from your Jekyll site after build using PurgeCSS. This plugin analyzes your site's content and configuration, then purges unused CSS to optimize performance and reduce file size—all managed seamlessly through your Jekyll configuration.

## Installation

Add this line to your Jekyll site's `_config.yml`:

```yml
plugins:
    # Other plugins
    - jekyll-purge-css
```

**NOTE:** It is best to add this line at the end of the plugins array.

Add this line to your Jekyll site's `Gemfile`:

```ruby
gem "jekyll-purge-css"
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install jekyll-purge-css
```

## Usage

To use this gem, you must configure it in `_config.yml` as follows:

```yml
PurgeCSS:
    # Array of Regex Patterns to files using CSS
    content:
        - _site/**/*.html
        - _site/**/*.js
    
    # Array of Regex Patterns to CSS files
    css:
        - _site/assets/*.css
        - _site/root.css
    
    # Array of Regex Patterns of CSS files to not Purge
    exclude:
        - _site/assets/do-not-purge.css
    
    # Location to store output
    output: _site/assets/

    # Option to ignore errors
    ignore: true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MUmarShahbaz/jekyll-purge-css. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/MUmarShahbaz/jekyll-purge-css/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll PurgeCSS project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MUmarShahbaz/jekyll-purge-css/blob/main/CODE_OF_CONDUCT.md).
