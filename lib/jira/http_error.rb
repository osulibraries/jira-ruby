require 'forwardable'
module JIRA

  class HTTPError < StandardError
    extend Forwardable

    delegate [:message, :code], :to => :response
    attr_reader :response

    def initialize(response)
      @response = response
    end

  end

end
