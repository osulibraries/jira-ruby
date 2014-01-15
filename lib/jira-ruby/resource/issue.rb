require 'cgi'

module JIRA
  module Resource

    class IssueFactory < JIRA::BaseFactory # :nodoc:
      def search(options = {})
        target_class.send('search', @client, options)
      end
    end

    class Issue < JIRA::Base

      has_one :reporter,  :class => JIRA::Resource::User,
                          :nested_under => 'fields'
      has_one :assignee,  :class => JIRA::Resource::User,
                          :nested_under => 'fields'
      has_one :project,   :nested_under => 'fields'

      has_one :issuetype, :nested_under => 'fields'

      has_one :priority,  :nested_under => 'fields'

      has_one :status,    :nested_under => 'fields'

      has_many :components, :nested_under => 'fields'

      has_many :comments, :nested_under => ['renderedFields','comment']

      # Attachment class for reading existing attachments, issue relation not required, since they have their own endpoint
      has_many :attachments, :nested_under => 'renderedFields',
                            :attribute_key => 'attachment'

      # Attachment class for adding new attachments, which are attached to Issue class
      has_many :attachment, :class => JIRA::Resource::IssueAttachment

      has_many :transitions, :attribute_key => 'transitions'

      has_many :versions, :nested_under => 'fields'

      has_many :worklogs, :nested_under => ['renderedFields','worklog']

      def self.all(client, options = {})
        JIRA::Resource::SearchResults.new(client, options)
      end

      def self.search(client, options = {})
        options[:jql] = options[:jql].to_s
        JIRA::Resource::SearchResults.new(client, options)
      end

      def self.jql(client, jql)
        url = client.options[:rest_base_path] + "/search?jql=" + CGI.escape(jql)
        response = client.get(url)
        json = parse_json(response.body)
        json['issues'].map do |issue|
          client.Issue.build(issue)
        end
      end

      def respond_to?(method_name)
        if attrs.keys.include?('fields') && attrs['fields'].keys.include?(method_name.to_s)
          true
        else
          super(method_name)
        end
      end

      def method_missing(method_name, *args, &block)
        if attrs.keys.include?('fields') && attrs['fields'].keys.include?(method_name.to_s)
          attrs['fields'][method_name.to_s]
        else
          super(method_name)
        end
      end

      def to_param
        key
      end

      def url
        super + '?expand=renderedFields'
      end
    end

  end
end
