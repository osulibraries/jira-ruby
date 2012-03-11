require 'json'
require 'forwardable'
require 'net/https'

module JIRA

  # This class is the main access point for all JIRA::Resource instances.
  #
  # The client must be initialized with a site, username, and password.
  # Additional options are:
  #
  #   :rest_base_path => "/rest/api/2"
  #
  # See the JIRA::Base class methods for all of the available methods on these accessor
  # objects.
  #
  class Client

    extend Forwardable

    # The configuration options for this client instance
    attr_reader :options

    delegate [:key, :secret, :get_request_token] => :consumer

    DEFAULT_OPTIONS = {
      :rest_base_path => "/rest/api/2",
      :site => nil,
      :username => nil,
      :password => nil
    }

    def initialize(options={})
      options = DEFAULT_OPTIONS.merge(options)

      @options = options
      @options.freeze

      @uri = URI.parse(@options[:site])
    end

    def Project # :nodoc:
      JIRA::Resource::ProjectFactory.new(self)
    end

    def Issue # :nodoc:
      JIRA::Resource::IssueFactory.new(self)
    end

    def Component # :nodoc:
      JIRA::Resource::ComponentFactory.new(self)
    end

    def User # :nodoc:
      JIRA::Resource::UserFactory.new(self)
    end

    def Issuetype # :nodoc:
      JIRA::Resource::IssuetypeFactory.new(self)
    end

    def Priority # :nodoc:
      JIRA::Resource::PriorityFactory.new(self)
    end

    def Status # :nodoc:
      JIRA::Resource::StatusFactory.new(self)
    end

    def Comment # :nodoc:
      JIRA::Resource::CommentFactory.new(self)
    end

    def Attachment # :nodoc:
      JIRA::Resource::AttachmentFactory.new(self)
    end

    def Worklog # :nodoc:
      JIRA::Resource::WorklogFactory.new(self)
    end

    def Version # :nodoc:
      JIRA::Resource::VersionFactory.new(self)
    end

    def Remotelink # :nodoc:
      JIRA::Resource::RemotelinkFactory.new(self)
    end

    # Returns the shared http object
    def http
      if @http.nil?
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = (@uri.port == 443)
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE      
      end

      @http
    end

    # HTTP methods without a body
    def delete(path, headers = {})
      execute_request(Net::HTTP::Delete.new(path, merge_default_headers(headers)))
    end

    def get(path, headers = {})
      execute_request(Net::HTTP::Get.new(path, merge_default_headers(headers)))
    end

    def head(path, headers = {})
      execute_request(Net::HTTP::Head.new(path, merge_default_headers(headers)))
    end

    # HTTP methods with a body
    def post(path, body = '', headers = {})
      headers = {'Content-Type' => 'application/json'}.merge(headers)
      request = Net::HTTP::Post.new(path, merge_default_headers(headers))
      request.body = body
      execute_request(request)
    end

    def put(path, body = '', headers = {})
      headers = {'Content-Type' => 'application/json'}.merge(headers)
      request = Net::HTTP::Put.new(path, merge_default_headers(headers))
      request.body = body
      execute_request(request)
    end

    protected

    def execute_request(request)
      request.basic_auth(@options[:username], @options[:password])
      http.request(request)
    end

    def merge_default_headers(headers)
      {'Accept' => 'application/json'}.merge(headers)
    end

  end
end
