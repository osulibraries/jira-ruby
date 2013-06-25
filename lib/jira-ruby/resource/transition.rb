module JIRA
  module Resource

    class TransitionFactory < JIRA::BaseFactory # :nodoc:
      def get_options issue_key
        url = client.options[:rest_base_path] + "/issue/#{issue_key}/transitions"
        response = client.get(url)
        json = Transition.parse_json(response.body)
        return json
      end
    end

    class Transition < JIRA::Base
      belongs_to :issue

      def self.endpoint_name
        'transitions'
      end
    end

  end
end
