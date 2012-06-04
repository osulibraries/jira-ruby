module JIRA
  module Resource


    class IssueAttachmentFactory < JIRA::BaseFactory # :nodoc:
    end

    class IssueAttachment < JIRA::Base
      belongs_to :issue
      has_one :author, :class => JIRA::Resource::User

      def self.endpoint_name
        'attachments'
      end

      def save!(upload)
        headers = {'Content-Type' => 'multipart/form-data', 'X-Atlassian-Token' => 'nocheck'}
        response = client.send(:upload, url, upload, headers)
        #set_attrs(attrs, false)
        set_attrs_from_response(response)
        @expanded = false
        true
      end

      def set_attrs_from_response(response)
        unless response.body.nil? or response.body.length < 2
          json = self.class.parse_json(response.body)
          if (json.is_a?(Array))
            json = json[0]
          end
          set_attrs(json)
        end
      end


    end
  end
end