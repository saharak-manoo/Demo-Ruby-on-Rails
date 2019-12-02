class VacationDecorator < ApplicationDecorator
  delegate_all

  def as_json(options = {})
    add_decorated_methods options, options[:decorator_methods]
    super options
  end

  def leave_html_color
    case object.leave_type
    when 'Sick-leave'
      text_color = '#ffcc00'
    when 'Half-day leave'
      text_color = '#0066ff'
    when 'Vacation'
      text_color = '#ff4d4d'
    end
  end

  def leave_text_color
    case object.leave_type
    when 'Sick-leave'
      text_color = 'text-warning'
    when 'Half-day leave'
      text_color = 'text-info'
    when 'Vacation'
      text_color = 'text-danger'
    end
  end

  def leave_type_color
    h.content_tag :span, class: "#{leave_text_color} font-weight-500" do
      "#{object.leave_type}".html_safe
    end
  end

  def start_date_formatted
    start_date.date_formatted
  end

  def end_date_formatted
    end_date.date_formatted
  end

  def total_vacation
    if start_date.to_date >= end_date.to_date
      object.half_day? ? 0.5 : 1
    else
      (end_date.to_date - start_date.to_date).to_i + 1
    end
  end

  def action_buttons
    h.button_to h.vacation_path(object), method: :delete, data: { confirm: 'แน่ใจแล้วใช่ไหม' }, class: "btn btn-outline-danger", remote: true do
      '<i class="far fa-trash-alt"></i>'.html_safe
    end
  end
end
