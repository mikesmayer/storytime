Storytime.configure do |config|
  # Name of the layout to be used. e.g. the 'application'
  # layout uses /app/views/layout/application, in your
  # host app, as the layout.
  # config.layout = 'application'

  # Name of the model you're using for Storytime users.
  config.user_class = 'User'

  # Path of Storytime's dashboard, relative to
  # Storytime's mount point within the host app.
  # config.dashboard_namespace_path = "/storytime"

  # Path of Storytime's home page, relative to
  # Storytime's mount point within the host app.
  # config.home_page_path = "/"

  # Path used to sign users in. 
  # config.login_path = '/users/sign_in'

  # Path used to log users out. 
  # config.logout_path = '/users/sign_out'

  # Method used for Storytime user logout path.
  # config.logout_method = :delete

  # Add custom post types to use within Storytime.
  # Make sure that the custom post types inherit the
  # from the Storytime::Post class.
  # config.post_types += ['CustomPostType']

  # Character limit for Storytime::Post.title <= 255
  # config.post_title_character_limit = 255

  # Character limit for Storytime::Post.excerpt
  # config.post_excerpt_character_limit = 500

  # Array of tags to allow from the Summernote WYSIWYG
  # Editor when editing Posts and custom post types.
  # An empty array, '', or nil setting will permit all tags.
  # config.whitelisted_html_tags = %w(p blockquote pre h1 h2 h3 h4 h5 h6 span ul li ol table tbody td br a img iframe hr)

  # Hook for handling post content sanitization.
  # Accepts either a Lambda or Proc which can be used to
  # handle how post content is sanitized (i.e. which tags,
  # HTML attributes to allow/disallow.
  # config.post_sanitizer = Proc.new do |draft_content|
  #   white_list_sanitizer = if Rails::VERSION::MINOR <= 1
  #     HTML::WhiteListSanitizer.new
  #   else
  #     Rails::Html::WhiteListSanitizer.new
  #   end

  #   attributes = %w(
  #     id class href style src title width height alt value 
  #     target rel align disabled
  #   )

  #   if Storytime.whitelisted_post_html_tags.blank?
  #     white_list_sanitizer.sanitize(draft_content, attributes: attributes)
  #   else
  #     white_list_sanitizer.sanitize(draft_content,
  #                                   tags: Storytime.whitelisted_post_html_tags,
  #                                   attributes: attributes)
  #   end
  # end

  # Enable Disqus comments using your forum's shortname,
  # the unique identifier for your website as registered on Disqus.
  # config.disqus_forum_shortname = ""

  # Enable Discourse comments using your discourse server,
  # Your discourse server must be configured for embedded comments.
  # e.g. config.discourse_name = "http://forum.example.com"
  # NOTE:  include the '/' suffix at the end of the url
  # config.discourse_name = ""

  # Email regex used to validate email format validity for subscriptions.
  # config.email_regexp = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  # Email address of the sender of subscription emails.
  # config.subscription_email_from = 'no-reply@example.com'

  # Search adapter to use for searching through Storytime Posts or
  # Post subclasses. Options for the search adapter include:
  # Storytime::PostgresSearchAdapter, Storytime::MysqlSearchAdapter,
  # Storytime::MysqlFulltextSearchAdapter, Storytime::Sqlite3SearchAdapter
  # config.search_adapter = ''

  # Hook for handling notification delivery when publishing content.
  # Accepts either a Lambda or Proc which can be set up to schedule
  # an ActiveJob (Rails 4.2+), for example:
  # 
  # config.on_publish_with_notifications = Proc.new do |post|
  #   wait_until = post.published_at + 1.minute
  #   StorytimePostNotificationJob.set(wait_until: wait_until).perform_later(post.id)
  # end
  # 
  ### In app/jobs/storytime_post_notification_job.rb:
  # class StorytimePostNotificationJob < ActiveJob::Base
  #   queue_as :mailers
  # 
  #   def perform(post_id)
  #     Storytime::PostNotifier.send_notifications_for(post_id)
  #   end
  # end
  config.on_publish_with_notifications = nil

  # File upload options.
  config.enable_file_upload = true

  if Rails.env.production?
    config.s3_bucket = 'my-s3-bucket'
    config.media_storage = :s3
  else
    config.media_storage = :file
  end
end
