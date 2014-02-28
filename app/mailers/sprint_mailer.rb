class SprintMailer < ActionMailer::Base
  default from: EMAIL_FROM

  def summary_email(person, sprint)
    @person = person
    @sprint = sprint
    @complete = sprint.user_stories.collect {|us| us.status == "complete" }
    @inprogress = sprint.user_stories.collect {|us| us.status == "inprogress" }
    @incomplete = sprint.user_stories.collect {|us| us.status == "incomplete" }
    mail(:to => invitation.email, :subject => "[Agileista] Sprint Summary")
  end
end
