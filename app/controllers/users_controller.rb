class UsersController < Devise::RegistrationsController
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @title = "Users"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @topics = @user.topics
    @comments = @user.comments

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /user/sign_up
  # GET /user/sign_up.json
  def new
    @user = build_resource({})

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    super
  end

  # GET /user/edit
  # GET /users/1/edit
  def edit
    id = params[:id] || current_user.id
    @user = User.find(id)
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    authorize! :assign_roles, @user if params[:user][:role]
    
    @user = User.find(params[:id])

    respond_to do |format|
      successfully_updated = if is_current? @user
        @user.update_with_password(resource_params)
      else
        @user.update_without_password(params[:user])
      end

      if successfully_updated
        if is_current? @user
          sign_in :user, @user, :bypass => true
          
          if is_navigational_format?
            if @user.respond_to?(:pending_reconfirmation?) && @user.pending_reconfirmation?
              flash_key = :update_needs_confirmation
            end
            set_flash_message :notice, flash_key || :updated
          end

          format.html { redirect_to after_update_path_for(@user) }
        else
          format.html { redirect_to users_url, :notice => 'User was successfully updated.' }          
        end

        format.json { head :no_content }
      else
        clean_up_passwords @user if is_current? @user

        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      if is_current? @user
        Devise.sign_out_all_scopes ? sign_out : sign_out(:user)
        set_flash_message :notice, :destroyed if is_navigational_format?

        format.html { redirect_to after_sign_out_path_for(:user) }
      else
        format.html { redirect_to users_url }
      end

      format.json { head :no_content }
    end
  end
end
