class ClassroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @classrooms = Classroom.all

    respond_to do |format|
      format.html
      format.json { bootstrap_table_data }
    end
  end

  def new
    @classroom = Classroom.new
  end

  def create
    classroom = Classroom.new(classroom_params.merge(created_by: current_user.email))

    if classroom.save
      redirect_to classrooms_path, success: 'Classroom was successfully created.'
    else
      redirect_to new_classroom_path(classroom), danger: classroom.errors.full_messages.to_sentence
    end   
  end

  def edit
    @classroom = Classroom.find_by(id: params[:id])
  end

  def update
    classroom = Classroom.find_by(id: params[:id])

    if classroom.update(classroom_params.merge(updated_by: current_user.email))
      redirect_to classrooms_path, info: 'Classroom was successfully updated.'
    else
      redirect_to edit_classroom_path(classroom), danger: classroom.errors.full_messages.to_sentence
    end   
  end

  def destroy
    classroom = Classroom.find_by(id: params[:id])
    classroom.destroy
    render 'refresh_table'
  end

  def subjects
    subjects = Classroom.find_by(id: params[:id]).subjects
    
    render json: { rows: subjects, total: subjects.size }
  end  

  private

  def bootstrap_table_data
    render json: {
      rows: @classrooms.decorate.as_json(decorator_methods:
        [
          :link_to_name,
          :status_color,
          :action_buttons
        ]),
      total:  @classrooms.count
    }
  end

  def classroom_params
    params.require(:classroom).permit(
      :name,
      :seat,
      :active
    )
  end
end  