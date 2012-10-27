require "rails/railtie"

class DynamicTaggedLogger < Rails::Railtie
  initializer "dynamic_tagged_logger.dynamic_tags" do
    ActiveSupport::TaggedLogging.class_eval do
      def tags_text
        tags = current_tags
        if tags.any?
          tags.collect{ |tag| 
            val = case tag
            when Proc
              tag.call()
            else
              tag
            end
            "[#{val}]" 
          }.join(" ") + " "
        end
      end
    end

    Rails.application.config.log_tags ||= [ lambda{|req| lambda{Time.now.strftime('%Y-%m-%d %H:%M:%S.%3N')} }, :uuid ]
  end

  initializer "dynamic_tagged_logger.uuid_in_call_app" do
    Rails::Rack::Logger.class_eval do
      protected
      def call_app(env)
        request = ActionDispatch::Request.new(env)
        path = request.filtered_path
        Rails.logger.info "\n\nStarted #{request.request_method} \"#{path}\" with uuid [#{request.uuid}] for #{request.ip} at #{Time.now.to_default_s}"
        @app.call(env)
      ensure
        ActiveSupport::LogSubscriber.flush_all!
      end
    end
  end
end
