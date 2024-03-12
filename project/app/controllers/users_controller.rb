class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @followships = @user.followships
    @blogs = Blog.all
    @blog = @user.blogs
    respond_to do |format|
      format.html{render :show}
      format.js
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def login
  end

  def do_login
    user = User.where(username: params[:username], password: params[:password]).first
    if user
      session[:current_userid] = user.id
      redirect_to blogs_url, notice: 'User login successfully.'
    else
      redirect_to login_users_url, notice: 'Wrong username or password!'
    end
  end
  def register
    @user = User.new
    render "users/register",locals:{user: @user}
  end
  def do_register
    user = User.new(user_params)

    respond_to do |format|
      if user.save
        format.html { redirect_to login_users_url, notice: "User was successfully created." }
        #format.json { render :show, status: :created, location: user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end
  def logout
    session.delete(:current_userid)
    redirect_to login_users_url,  notice: 'User logout successfully!'
  end
  def do_follow
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
    if current_user.followings.include?@user
      current_user.followings.destroy(@user)
      puts 1
    else
      puts 2
      followship = Followship.new(follower:current_user,following:@user)
      puts followship.save
      puts followship.errors.full_messages
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
