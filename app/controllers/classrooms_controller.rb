class ClassroomsController < ApplicationController

  def index
    ap '>>>>>>>>>>>'
    ap 'Banana'
    @classrooms = Classroom.all

    respond_to do |format|
      format.html
      format.json { bootstrap_table_data }
    end
  end

  def new
    @classroom = Classroom.new
  end  

  def bootstrap_table_data
    render json: {
      rows: @classrooms,
      total:  @classrooms.count
    }
  end  
end  