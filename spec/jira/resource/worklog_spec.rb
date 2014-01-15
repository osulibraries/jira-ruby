require 'spec_helper'

describe JIRA::Resource::Worklog do

  let(:client) { double() }

  describe "relationships" do
    subject {
      JIRA::Resource::Worklog.new(client, :issue_id => '99999', :attrs => {
        'author' => {'foo' => 'bar'},
        'updateAuthor' => {'foo' => 'bar'}
      })
    }

    it "has the correct relationships" do
      subject.should have_one(:author, JIRA::Resource::User)
      subject.author.foo.should == 'bar'

      subject.should have_one(:update_author, JIRA::Resource::User)
      subject.update_author.foo.should == 'bar'
    end
  end

end
