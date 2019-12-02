class RegisterCourseDecorator < ApplicationDecorator
  delegate_all

  def as_json(options = {})
    add_decorated_methods options, options[:decorator_methods]
    super options
  end

  def student_code
    object.student.decorate.student_code
  end

  def student_name
    object.student.decorate.full_name
  end

  def subject_code
    object.subject.subject_code
  end

  def subject_name
    object.subject.name
  end

  def subject_credit
    object.subject.credit
  end

  def register
    created_at.date_formatted
  end

  def action_buttons
    unless object.deleted?
      h.button_to h.register_course_path(object),
                class: 'btn btn-outline-danger',
                remote: true,
                method: :delete,
                data: { confirm: h.t('แน่ใจแล้วใช่ไหม') } do
        '<i class="far fa-trash-alt"></i>'.html_safe
      end
    else
      h.button_to h.restore_deletion_register_course_path(object),
                class: 'btn btn-outline-warning',
                remote: true,
                method: :get,
                data: { confirm: h.t('แน่ใจแล้วใช่ไหม ที่จะนำข้อมูลกลับมา') } do
        '<i class="fas fa-trash-restore-alt"></i>'.html_safe
      end
    end
  end

  def actions
    text_color = ''
    action = ''

    unless object.deleted?
      text_color = 'text-success'
      action = 'เพิ่มวิชา'
    else
      text_color = 'text-danger'
      action = 'ถอดวิชา'
    end

    h.content_tag :span, class: "#{text_color} font-weight-500" do
      "#{action}".html_safe
    end
  end

  def delete_register
    deleted_at&.date_formatted || 'ยังไม่มีข้อมูล'
  end
end
