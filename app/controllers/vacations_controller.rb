class VacationsController < ApplicationController
  before_action :authenticate_user!, :load_resources
  LEAVE_TYPES = ['Vacation', 'Sick-leave', 'Half-day leave']

  def index
    respond_to do |format|
      format.html
      format.json { bootstrap_table_data }
    end
  end

  def show_modal
    @student = Student.find_by(id: params[:id])
    @vacation = Vacation.new
  end

  def create
    @vacation = Vacation.new(vacation_params)
    @student = Student.find_by(id: @vacation.student_id)
    if @vacation.half_day?
      date = @vacation.start_date
      if vacation_params[:half_day] == 'true'
        @vacation.start_date = DateTime.new(date.year, date.month, date.day, 00, 00, 00)
        @vacation.end_date = DateTime.new(date.year, date.month, date.day, 12, 00, 00)
      else
        @vacation.start_date = DateTime.new(date.year, date.month, date.day, 12, 00, 00)
        @vacation.end_date = DateTime.new(date.year, date.month, date.day, 23, 59, 59)
      end
    end

    sum_vacations = @student.decorate.total_vacations + @vacation.decorate.total_vacation
    if sum_vacations <= @student.total_vacation
      @vacation.save
    else
      @vacation.errors.add(:base, "ไม่สามารถลาได้ เนื่องจากวันลาคงเหลือไม่เพียงพอ จำนวนวันที่คุณจะลา #{@vacation.decorate.total_vacation} วัน จำนวนวันที่สามารถลาได้ #{@student.total_vacation - @student.decorate.total_vacations} วัน")
    end

    render 'refresh_table'
  end

  def calendar
    render json: all_calendar
  end

  def all_calendar
    filter_vacation

    datas = []
    @vacations.each do |vacation|
      datas << {
        title: "#{vacation.leave_type } : #{vacation.student.decorate.full_name_text}",
        start: vacation.start_date.datetime_for_calender,
        end: vacation.end_date.datetime_for_calender,
        description: vacation.detail,
        color: vacation.decorate.leave_html_color,
        total_date: vacation.decorate.total_vacation,
        allDay: !vacation.half_day?
      }
    end

    return datas
  end

  def destroy
    @vacation = Vacation.find_by(id: params[:id])
    @student = Student.find_by(id: @vacation.student_id)
    @vacation.destroy

    render 'refresh_table'
  end

  private

  def load_resources
    @vacations = Vacation.all
    @leave_types = LEAVE_TYPES
  end

  def filter_vacation
    @vacations = @vacations.where(student_id: params[:student_id]) if params[:student_id].present?
  end

  def bootstrap_table_data
    filter_vacation

    total = @vacations.count
    @vacations = @vacations.limit(params[:limit]).offset(params[:offset])

    render json: {
      rows: @vacations.decorate.as_json(decorator_methods:
        [
          :leave_type_color,
          :detail,
          :start_date_formatted,
          :end_date_formatted,
          :total_vacation,
          :action_buttons
        ]),
      total: total
    }
  end

  def vacation_params
    params.require(:vacation).permit(:detail, :leave_type, :student_id, :start_date, :end_date, :half_day)
  end
end
