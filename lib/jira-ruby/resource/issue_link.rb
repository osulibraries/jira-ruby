module JIRA
  module Resource

    class IssueLinkFactory < JIRA::BaseFactory # :nodoc:
    end

    class IssueLink < JIRA::Base
      def self.endpoint_name
        'issueLink'
      end
    end
  end
end