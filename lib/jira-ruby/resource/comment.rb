module JIRA
  module Resource

    class CommentFactory < JIRA::BaseFactory # :nodoc:
    end

    class Comment < JIRA::Base
      belongs_to :issue

      has_one :author,  :class => JIRA::Resource::User
      has_one :update_author, :class => JIRA::Resource::User,
              :attribute_key => "updateAuthor"


      nested_collections true
    end

  end
end
