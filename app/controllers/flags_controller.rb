class FlagsController < ApplicationController
  before_action :set_flag, only: [:show, :edit, :update, :destroy]
  before_action :set_user_location

  # GET /flags
  # GET /flags.json
  def index
    redirect_to splash_path unless current_user
    @flags = Flag.all
  end

  # GET /flags/1
  # GET /flags/1.json
  def show

  end

  # GET /flags/new
  def new
    @flag = Flag.new
  end

  # GET /flags/1/edit
  def edit
  end

  # POST /flags
  # POST /flags.json
  def create
    @flag = current_user.flags.create(flag_params)
    @flag.latitude = current_user.latitude
    @flag.longitude = current_user.longitude

    respond_to do |format|
      if @flag.save
        format.html { redirect_to @flag, notice: 'Flag was successfully created.' }
        format.json { render :show, status: :created, location: @flag }
      else
        format.html { render :new }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flags/1
  # PATCH/PUT /flags/1.json
  def update
    respond_to do |format|
      if @flag.update(flag_params)
        format.html { redirect_to @flag, notice: 'Flag was successfully updated.' }
        format.json { render :show, status: :ok, location: @flag }
      else
        format.html { render :edit }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag.destroy
    respond_to do |format|
      format.html { redirect_to flags_url, notice: 'Flag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag
      @flag = Flag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flag_params
      params.require(:flag).permit(:name, :description, :user_id)
    end

    def set_user_location
      if cookies[:lat_lng]
        location = cookies[:lat_lng].split("|")
        current_user.latitude = location[0]
        current_user.longitude = location[1]
        current_user.last_ping_time = DateTime.now().change(:offset =>"+0000")
        current_user.save
        cookies.delete :lat_lng
      end
    end
end
