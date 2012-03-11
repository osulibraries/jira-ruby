$: << File.expand_path(File.dirname(__FILE__))

require 'active_support/inflector'
ActiveSupport::Inflector.inflections do |inflector|
  inflector.singular 'status', 'status'
end

require 'jira-ruby/base'
require 'jira-ruby/base_factory'
require 'jira-ruby/has_many_proxy'
require 'jira-ruby/http_error'

require 'jira-ruby/resource/user'
require 'jira-ruby/resource/attachment'
require 'jira-ruby/resource/component'
require 'jira-ruby/resource/issuetype'
require 'jira-ruby/resource/version'
require 'jira-ruby/resource/project'
require 'jira-ruby/resource/priority'
require 'jira-ruby/resource/remotelink'
require 'jira-ruby/resource/status'
require 'jira-ruby/resource/comment'
require 'jira-ruby/resource/worklog'
require 'jira-ruby/resource/issue'
require 'jira-ruby/resource/search_results'

require 'jira-ruby/client'

require 'jira-ruby/railtie' if defined?(Rails)
