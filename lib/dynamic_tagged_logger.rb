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

      def started_request_message(request)
        'Started %s "%s" with uuid [%s] for %s at %s' % [
          request.request_method,
          request.filtered_path,
          request.uuid,
          request.ip,
          Time.now.to_default_s ]
      end
    end
  end
end
