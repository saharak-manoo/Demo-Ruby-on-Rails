class RegisterCoursesController < ApplicationController
  before_action :authenticate_user!, :load_resources

  def index
    respond_to do |format|
      format.html
      format.json { bootstrap_table_data }
    end
  end

  def show_modal
    @student = Student.find_by(id: params[:id])
    @subjects = Subject.all
    @register_course = RegisterCourse.new
  end

  def create
    @register_course = RegisterCourse.new(register_course_params)
    @student = Student.find_by(id: @register_course.student_id)
    @register_course.save

    render 'refresh_table'
  end

  def destroy
    @student = Student.find_by(id: @register_course.student_id)
    @register_course.destroy

    render 'refresh_table'
  end

  def restore_deletion
    @register_course = RegisterCourse.only_deleted.find_by(id: params[:id])
    @student = Student.find_by(id: @register_course.student_id)
    @register_course.restore unless @register_course.prohibit_less_than_zero if @register_course.uniqueness_subject

    render 'refresh_table'
  end

  def delete_subject
    respond_to do |format|
      format.html
      format.json { bootstrap_table_data_for_deleted }
    end
  end

  def all
    @register_courses = RegisterCourse.with_deleted

    respond_to do |format|
      format.html
      format.json { bootstrap_table_data }
    end
  end

  private

  def load_resources
    @register_course = RegisterCourse.find_by(id: params[:id])
    @register_courses = RegisterCourse.all
  end

  def filter_register_course
    @register_courses = @register_courses.where(student_id: params[:student_id]) if params[:student_id].present?
  end

  def bootstrap_table_data
    filter_register_course

    total = @register_courses.count
    @register_courses = @register_courses.limit(params[:limit]).offset(params[:offset])

    render json: {
      rows: @register_courses.decorate.as_json(decorator_methods:
        [
          :actions,
          :student_code,
          :student_name,
          :subject_code,
          :subject_name,
          :subject_credit,
          :register,
          :action_buttons,
          :delete_register
        ]),
      total: total
    }
  end

  def bootstrap_table_data_for_deleted
    @register_courses = RegisterCourse.only_deleted
    filter_register_course

    total = @register_courses.count
    @register_courses = @register_courses.limit(params[:limit]).offset(params[:offset])

    render json: {
      rows: @register_courses.decorate.as_json(decorator_methods:
        [
          :actions,
          :subject_code,
          :subject_name,
          :subject_credit,
          :register,
          :delete_register,
          :action_buttons
        ]),
      total: total
    }
  end

  def register_course_params
    params.require(:register_course).permit(:subject_id, :student_id)
  end
end
