module JIRA
  module Resource

    class AttachFactory < JIRA::BaseFactory # :nodoc:
    end

    class Attach < JIRA::Base
      belongs_to :issue

      def self.endpoint_name
        'attachments'
      end
    end

  end
end
