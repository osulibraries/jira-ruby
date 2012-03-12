module JIRA
  module Resource

    class VersionFactory < JIRA::BaseFactory # :nodoc:
    end

    class Version < JIRA::Base

      def archived?
        archived
      end

      def released?
        released
      end

      def to_param
        id
      end
    end

  end
end
