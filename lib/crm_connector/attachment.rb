module Infopark
  module Crm

    class Attachment < Core::Resource

      class Permission < Struct.new(:url, :fields, :upload_id)
      end

      ##
      # Generates a temporary Amazon S3 URL for uploading a file to S3.
      # @return [Permission]
      # @webcrm_rest_url <code>GET /api/attachments/upload_permission</code>
      # @see https://dev.infopark.net/26635f6d056215c9/attachments
      # @example
      #   permission = Infopark::Crm::Attachment.upload_permission
      def self.upload_permission
        perm = get(:upload_permission)
        Permission.new(perm["url"], perm["fields"], perm["upload_id"])
      end

      ##
      # Generates a temporary download URL for the given attachment.
      # @param attachment_id [String] An attachment ID taken from the attachments field inside the comments section of an activity.
      # @param activity_id [String] The activity ID the attachment belongs to
      # @return [String]
      # @webcrm_rest_url <code>GET /api/attachments/download_url</code>
      # @see https://dev.infopark.net/26635f6d056215c9/attachments
      # @example
      #   url = Infopark::Crm::Attachment.download_url("c972c011b52ba671b68b16db961b82e7", "ff30a81adaaae7bd5a7066c350530c41")
      def self.download_url(attachment_id, activity_id)
        get(:download_url, :attachment_id => attachment_id, :activity_id => activity_id)
      end

    end

  end
end
