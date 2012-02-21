require 'rubygems'
require 'pp'
require './lib/jira'

client = JIRA::Client.new({ :site => "http://localhost:2990", :username => "admin", :password => "admin", :rest_base_path => "/jira/rest/api/2"})

# Show all projects
projects = client.Project.all

projects.each do |project|
  puts "Project -> key: #{project.key}, name: #{project.name}"
end
issue = client.Issue.find('SAMPLEPROJECT-1')
pp issue

# # Find a specific project by key
# # ------------------------------
# project = client.Project.find('SAMPLEPROJECT')
# pp project
# project.issues.each do |issue|
#   puts "#{issue.id} - #{issue.fields['summary']}"
# end
#
# # List all Issues
# # ---------------
# client.Issue.all.each do |issue|
#   puts "#{issue.id} - #{issue.fields['summary']}"
# end
#
# # Delete an issue
# # ---------------
# issue = client.Issue.find('SAMPLEPROJECT-2')
# if issue.delete
#   puts "Delete of issue SAMPLEPROJECT-2 sucessful"
# else
#   puts "Delete of issue SAMPLEPROJECT-2 failed"
# end
#
# # Create an issue
# # ---------------
# issue = client.Issue.build
# issue.save({"fields"=>{"summary"=>"blarg from in example.rb","project"=>{"id"=>"10001"},"issuetype"=>{"id"=>"3"}}})
# issue.fetch
# pp issue
#
# # Update an issue
# # ---------------
# issue = client.Issue.find("10002")
# issue.save({"fields"=>{"summary"=>"EVEN MOOOOOOARRR NINJAAAA!"}})
# pp issue
#
# # Find a user
# # -----------
# user = client.User.find('admin')
# pp user
#
# # Get all issue types
# # -------------------
# issuetypes = client.Issuetype.all
# pp issuetypes
#
# # Get a single issue type
# # -----------------------
# issuetype = client.Issuetype.find('5')
# pp issuetype
#
# #  Get all comments for an issue
# #  -----------------------------
# issue.comments.each do |comment|
#   pp comment
# end
#
# # Build and Save a comment
# # ------------------------
# comment = issue.comments.build
# comment.save!(:body => "New comment from example script")
#
# # Delete a comment from the collection
# # ------------------------------------
# issue.comments.last.delete
#
# # Update an existing comment
# # --------------------------
# issue.comments.first.save({"body" => "an updated comment frome example.rb"})
