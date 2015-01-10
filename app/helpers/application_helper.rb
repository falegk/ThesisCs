module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "ThesisCs"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # έλεγχος ρόλου απο την βάση
  def get_role
    if current_user.student
      "student"
    elsif current_user.teacher
      "teacher"
    else
      "none role"
    end
  end

  def is_student_helper?
    current_user.student
  end

  def is_teacher_helper?
    current_user.teacher
  end


  # Λίστα φοιτητών που έχουν πάρει την πτυχιακή
  def students_list(project_id)
   list = ProjectAssignment.where(given: true, project_id: project_id)



    result = {
        count: list.count
    }
  end

end
