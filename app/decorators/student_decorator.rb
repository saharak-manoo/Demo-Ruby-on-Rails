class StudentDecorator < ApplicationDecorator
  delegate_all

  def as_json(options = {})
    add_decorated_methods options, options[:decorator_methods]
    super options
  end

  def student_code
    "#{sprintf '%010d', id}"
  end

  def full_name
    h.link_to("#{first_name.capitalize} #{last_name.capitalize}", h.student_path(object), id: "student-id-#{id}")
  end

  def full_name_text
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def create_at
    created_at.date_formatted
  end

  def status_color
    text_color = ''
    icon = ''

    case object.status
    when 'กำลังศึกษา'
      text_color = 'text-warning'
    when 'จบการศึกษา'
      text_color = 'text-success'
    when 'ลาออก'
      text_color = 'text-danger'
    end

    h.content_tag :span, class: "#{text_color} font-weight-500" do
      "#{icon}#{object.status.capitalize}".html_safe
    end
  end

  def class_level
    object.class_level.name
  end

  def action_buttons
    h.button_to h.edit_student_path(object),
      method: :get,
      class: "btn btn-outline-warning",
      remote: true do
    '<i class="fas fa-edit"></i>'.html_safe
    end
  end

  def sum_credits
    credits = 0
    object.register_courses.each { |x| credits += x.subject.credit }
    credits = object.credits_earned - credits
  end

  def total_vacations
    object.vacations.map { |x| x.decorate.total_vacation }.sum
  end
end
