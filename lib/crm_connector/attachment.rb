module Infopark
  module Crm

    class Attachment < Core::Resource

      def self.generate_upload_permission
        get(:upload_permission)
      end

      def self.generate_download_url(attachment_id, activity_id)
        url = get(:download_url, :attachment_id => attachment_id, :activity_id => activity_id)
        # workaround different behavior of ActiveResource 3.0
        if url.is_a?(Hash) && url.has_key?("url")
          url = url["url"]
        end
        url
      end

    end

  end
end
