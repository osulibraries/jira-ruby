module JIRA
  module Resource

    class RemotelinkFactory < JIRA::BaseFactory # :nodoc:
    end

    class Remotelink < JIRA::Base
      belongs_to :issue
    end
  end
end
