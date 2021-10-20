class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  def index
    @doctors = Doctor.all.paginate(page: params[:page],per_page: 4)
    
  end

  def show
  end

  def new
     @doctor = Doctor.new
    
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to doctors_path
    else
      flash[:error] = 'Failed to add new doctor!'   
      render :new
    end
  end
  
  def edit
   
  end

  def update
    
    @doctor.update(doctor_params)

    if @doctor.save
      redirect_to doctors_path
    else
      flash[:error] = 'Failed to add Edit doctor!'   
      render :edit
    end
  end

  def destroy
    @doctor.destroy
    redirect_to doctors_path
  end

  private
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def doctor_params
      params.require(:doctor).permit(:name, :specialty, :school, :phone)
    end
end
