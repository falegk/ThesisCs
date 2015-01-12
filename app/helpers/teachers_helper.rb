module TeachersHelper

  # Επιστρέφει ονόματα φοιτητών
  def students_list(student, link)
    if link == true
      link_to "#{student.user.last_name} #{student.user.first_name}",  profile_student_path(student)
    else
      "#{student.user.last_name} #{student.user.first_name}"
    end
  end


  def project_assignment_result(project_id, given)
    ProjectAssignment.where(given: given, project_id: project_id)
  end


  # Επιστρέφει την φράση στον ενικό ή πληθυντικό ανάλογα με το πλήθος αποτελεσμάτων του ερωτήματος
  # @counter true/false
  def plural_students_expressed_interest(project_id, given, counter, singular, plural)
    count = ProjectAssignment.where(given: given, project_id: project_id).count
    "#{count if counter == true} #{count == 1 ? singular : plural }"
  end

end
