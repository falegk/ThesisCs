class UserMailer < ActionMailer::Base
  default from: "thesiscs@teilar.gr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.expression_interest.subject
  #
  def expression_interest(teacher, student, project)
    @teacher = teacher
    @student = student
    @project = project

    mail to: "to@teacher.org", subject: "Εκδήλωση ενδιαφέροντος για πτυχιακή"
  end

  def deadline_completion(teacher, student, project)
    @teacher = teacher
    @student = student
    @project = project

    mail to: "to@student.org", subject: "Προθεσμία ολοκλήρωσης πτυχιακής εργασίας"
  end

  def project_assignment(teacher, student, project)
    @teacher = teacher
    @student = student
    @project = project

    mail to: "to@student.org", subject: "Ανάθεση θέματος πτυχιακής εργασία"
  end
end
