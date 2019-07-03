class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def login_form

  end

  def login

    @user = User.find_by(email:params[:email])

    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      session[:user_id] = @user.id
      redirect_to("/talks/index")

    else
      @email = params[:email]
      @password = params[:password]
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")

    end

  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(name:params[:name], email:params[:email], image_name:"default_user.jpg", password:params[:password])
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      render("/users/new")
    end

  end

  def edit

      @user = User.find_by(id:params[:id])

  end

  def update

    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image=params[:image]
      File.binwrite("Public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("/users/edit")
    end

  end

  def talkentry

      @partner = User.find_by(id:params[:id])

      @talk = Talk.new(name: @partner.name + "と" + @current_user.name )
      if @talk.save
        @member = Member.new(talk_id:@talk.id, user_id:@partner.id)
        if @member.save
          @member = Member.new(talk_id:@talk.id, user_id:@current_user.id)
          if @member.save
            flash[:notice] = "新しいルームを作成しました。"
            redirect_to("/talks/#{@talk.id}")
          else
            render("/users/#{@user.id}")
          end
        else
          render("/users/#{@user.id}")
        end
      else
        render("/users/#{@user.id}")
      end
  end

  def logout

    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")

  end

  def ensure_correct_user

    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end

  end

end
