class UserMailer < ActionMailer::Base
  default from: 'ThesisCs <thesiscs@teilar.gr>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.expression_interest.subject
  #
  def expression_interest(teacher, student, project)
    @teacherInfo = teacher
    @studentInfo = student
    @projectInfo = project

    mail to: @teacherInfo.email_communication, subject: "Εκδήλωση ενδιαφέροντος για πτυχιακή"
  end

  def deadline_completion(teacher, student, project)
    @teacherInfo = teacher
    @studentInfo = student
    @projectInfo = project

    mail to: "" , subject: "Προθεσμία ολοκλήρωσης πτυχιακής εργασίας"
  end

  def project_assignment(teacher, student, project)
    @teacherInfo = teacher
    @studentInfo = student
    @projectInfo = project

    mail to: @studentInfo.email_communication, subject: "Ανάθεση θέματος πτυχιακής εργασία"
  end
end
