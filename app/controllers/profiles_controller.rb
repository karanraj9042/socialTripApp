require_relative '../decorators/full_name_decorator.rb'
require_relative '../decorators/profiles_decorator.rb'

class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    #profile decoration with Full name
    #@decorated_profile = ProfileDecorator.decorate(@profile).full_name
    @decorated_profile = FullNameDecorator.new(@profile)
  end

  # GET /profiles/new
  def new
    #if user has new profile then load that otherwse load new profile.
   profile = Profile.find_by_user_id(current_user.id)
   if profile.nil?
      @profile = Profile.new
      @profile.user_id = current_user.id
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @profile }
      end
    else
        flash[:error] =  "You can not create more than one profile."
        redirect_to profiles_url and return 
   end
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def signedinuserprofile
      profile = Profile.find_by_user_id(current_user.id)
     if profile.nil?
        redirect_to "/profiles/new"
     else
        @profile = Profile.find_by_user_id(current_user.id)
        redirect_to "/profiles/#{@profile.id}"
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstname, :lastname, :likedevent, :likedvenue, :address, :user_id)
    end
end
