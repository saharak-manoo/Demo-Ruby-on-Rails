class TeachersController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { bootstrap_table_data }
    end
  end

  def show_modal
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    @teacher.save
    render 'refresh_table'
  end

  private

  def filter_teacher
    @teachers = Teacher.all
  end

  def bootstrap_table_data
    filter_teacher

    total = @teachers.count
    @teachers = @teachers.limit(params[:limit]).offset(params[:offset])

    render json: {
      rows: @teachers.decorate.as_json(decorator_methods:
        [
          :full_name,
          :create_at,
          :action_buttons
        ]),
      total: total
    }
  end

  def teacher_params
    params.require(:teacher).permit(
      :first_name,
      :last_name
    )
  end
end
