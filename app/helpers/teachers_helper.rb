module TeachersHelper

  # Returns names of students
  def students_list(student, link)
    if link
      link_to "#{student.user.last_name} #{student.user.first_name}",  profile_student_path(student)
    else
      "#{student.user.last_name} #{student.user.first_name}"
    end
  end


  def project_assignment_result(project_id, given)
    ProjectAssignment.where(given: given, project_id: project_id)
  end


  # Returns the words in the singular or plural depending on the number of query results
  # @counter true/false
  # @given true/false
  def plural_students_expressed_interest(project_id, given, counter, singular, plural)
    count = ProjectAssignment.where(given: given, project_id: project_id).count
    "#{count if counter} #{count == 1 ? singular : plural }"
  end

end
