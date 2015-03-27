module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'ThesisCs'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def flash_class(choice)
    case choice
      when 'notice' then
        'alert alert-info alert-dismissable'
      when 'success' then
        'alert alert-success alert-dismissable'
      when 'error' then
        'alert alert-error alert-dismissable'
      when 'alert' then
        'alert alert-dismissable'
      else
        'alert alert-info alert-dismissable'
    end
  end

  # έλεγχος ρόλου απο την βάση
  def get_role
    if current_user.student
      'student'
    elsif current_user.teacher
      'teacher'
    else
      'none role'
    end
  end

  def is_student_helper?
    current_user.student
  end

  def is_teacher_helper?
    current_user.teacher
  end


end
