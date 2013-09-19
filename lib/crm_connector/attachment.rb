module Infopark
  module Crm

    class Attachment < Core::Resource

      def self.generate_upload_permission
        get(:upload_permission)
      end

      def self.generate_download_url(attachment_id, activity_id)
        get(:download_url, :attachment_id => attachment_id, :activity_id => activity_id)
      end

    end

  end
end
