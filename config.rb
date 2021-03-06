# coding: utf-8

###
# Requires
###
require "lib/lang_code"
require "lib/navi_menu"
require "lib/lang_helper"
###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :build_dir, 'build'

set :partials_dir, 'partials'

set :markdown_engine, :kramdown

set :slim,
    pretty: true, sort_attrs: false, format: :html5, disable_escape: false
Slim::Engine.disable_option_validator!

page "/lang/*", :layout => "lang"

page "/plain/*", :layout => "plain"

activate :lang_code
activate :navi_menu
activate :lang_helper

extensions[:lang_code].all_code_list.each do |code_path|
  proxy "/code/#{code_path}.txt", "/code/lang.text",
      locals: {code_path: code_path}, ignore: true
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :minify_html

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.remote = 'git@github.com:raccy/raccy.github.io.git'
  deploy.branch = 'master'
  deploy.strategy = :force_push
  deploy.commit_message = "自動コミット " +
      Time.now.strftime('%Y日%m月%d日%H時%M分%S秒(%Z)')
end
