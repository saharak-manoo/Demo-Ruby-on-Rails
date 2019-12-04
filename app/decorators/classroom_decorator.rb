class ClassroomDecorator < ApplicationDecorator
  delegate_all

  def as_json(options = {})
    add_decorated_methods options, options[:decorator_methods]
    super options
  end

  def link_to_name
    h.link_to(name.capitalize, h.edit_classroom_path(object))
  end
  
  def status_color
    text_color = 'text-danger'
    text_color = 'text-success' if object.active

    h.content_tag :span, class: "#{text_color} font-weight-500" do
      "#{object.active ? 'ว่าง' : 'ไม่ว่าง'}".html_safe
    end
  end

  def action_buttons
    h.button_to h.classroom_path(object),
      method: :delete,
      class: "btn btn-outline-danger",
      data: { confirm: 'แน่ใจแล้วใช่ไหม' },
      remote: true do
      'ลบ'.html_safe
    end
  end
end  