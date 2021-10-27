class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show]
  before_action :set_doctor
  before_action :set_patients, only: [:new, :create]
  require 'time'
  def index
    @appointments = @doctor.appointments.order(:date, :time)
  end


  def new
    @appointment = @doctor.appointments.new
  end

  def create
  
    @appointment = @doctor.appointments.new(appointment_params)
    datetime=("2000-01-01 " + (params[:appointment][:time]) + ":00:00").to_datetime

    @appt=Appointment.where("doctor_id = ? and date = ? and time = ?", params[:doctor_id], params[:appointment][:date], datetime).count
       
    if @appt > 0

      # flash.now[:alert] = 'Appointment have. Change other Time!' 
      redirect_to new_doctor_appointment_path, error: "Appointment have. Change other Time!"
  
    else
      if @appointment.save
        redirect_to doctor_appointments_path
      else
        render :new
      end
    end
  end


  def edit
    @doctor=set_doctor
    @appointment=set_appointment
    @patient=set_patients
  end

  def update
    @appointment = Appointment.find(params[:id])
    datetime=("2000-01-01 " + (params[:appointment][:time]) + ":00:00").to_datetime

    @appt=Appointment.where("doctor_id = ? and date = ? and time = ?", params[:doctor_id], params[:appointment][:date], datetime).count
       
    if @appt > 0
      
      redirect_to edit_doctor_appointment_path, error: "Appointment have. Change other Time!"
  
    else
      if @appointment.update(update_appointment_params)
        redirect_to doctor_appointments_path
      else
        render :edit
      end
    end
  end
  

  def destroy
    @doctor.appointments.find(params[:id]).destroy
    redirect_to doctor_appointments_path
  end

  private
    def set_doctor
      @doctor = Doctor.find(params[:doctor_id])
    end

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_patients
      @patients = (Patient.all.order("last_name") - @doctor.patients)
    end

    def appointment_params
      params.require(:appointment).permit(:patient_id, :date, :time)
    end

    def update_appointment_params
      params.require(:appointment).permit(:date, :time)
    end
end


