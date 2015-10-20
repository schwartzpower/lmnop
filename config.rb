###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

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
helpers do
  def current_page?(path)
    current_page.url.chomp('/') == path.chomp('/')
  end
end


# A path which all have the same layout
with_layout :layout do
  page "/"
  page "/map"
end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end


set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# set :fonts_dir,  'fonts'

# Activate sync extension
activate :sync do |sync|

  Fog.credentials = { :path_style => true }
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = '' # Your bucket name
  sync.fog_region = 'us-east-1' # The region your storage bucket is in (eg us-east-1, us-west-1, eu-west-1, ap-southeast-1 )

  sync.aws_access_key_id = ''
  sync.aws_secret_access_key = ''
  sync.existing_remote_files = 'delete' # What to do with your existing remote files? ( keep or delete )
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end


# Build-specific configuration
configure :build do

  # set :css_dir, '//key.cloudfront.net/stylesheets'
  # set :js_dir, '//key.cloudfront.net/javascripts'
  # set :images_dir, '//key.cloudfront.net/images'
  # set :fonts_dir,  '//key.cloudfront.net/fonts'

  ignore 'images/*.psd'
  ignore 'stylesheets/lib/*'
  ignore 'stylesheets/vendor/*'
  ignore 'javascripts/lib/*'
  ignore 'javascripts/vendor/*'
  ignore 'javascripts/bootstrap/*'


  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Finterprint assets
  activate :asset_hash

  # Enable Asset Hosts
  activate :asset_host

  # Why a block instead of a string? Because asset_host sometimes calculates stuff like
  # a1.*, a2.* to allow more open connections. We don't use that, but we do have to pass
  # the CloudFront CDN into the block so that this will even work.
  set :asset_host do |asset|
    '//key.cloudfront.net'.to_s
  end


  activate :s3_sync do |s3_sync|
    s3_sync.region                     = 'us-east-1'     # The AWS region for your bucket.
    s3_sync.bucket                     = '' # The name of the S3 bucket you are targetting. This is globally unique.

    s3_sync.aws_access_key_id          = ''
    s3_sync.aws_secret_access_key      = ''

    s3_sync.delete                     = false # We delete stray files by default.
    s3_sync.after_build                = true # We do not chain after the build step by default.
    s3_sync.prefer_gzip                = true
    s3_sync.path_style                 = true
    s3_sync.reduced_redundancy_storage = false
    s3_sync.acl                        = 'public-read'
    s3_sync.encryption                 = false
  end

  # Enable cache buster
  #activate :cache_buster

  # Use relative URLs
  #set :relative_assets, false

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
