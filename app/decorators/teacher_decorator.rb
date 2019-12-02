class TeacherDecorator < ApplicationDecorator
  delegate_all

  def as_json(options = {})
    add_decorated_methods options, options[:decorator_methods]
    super options
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def create_at
    created_at.date_formatted
  end
end
