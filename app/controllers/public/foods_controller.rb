class Public::FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:update, :destroy, :edit]

  def index
    @foods = Food.page(params[:page]).per(15).order(created_at: :desc)
    @user = current_user
    @genres = Genre.all
  end

  def new
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
    @user = @food.user
    @food_comment = FoodComment.new
  end

  def edit
    @food = Food.find(params[:id])
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to food_path(@food.id)
    else
      render :new
    end
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      flash[:notice] = "投稿内容を変更しました。"
      redirect_to food_path(@food.id)
    else
      render 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to user_path(current_user.id)
    end
  end

  private

  def food_params
    params.require(:food).permit(:genre_id, :title, :menu, :point, :food_image)
  end

  def is_matching_login_user
    food = Food.find(params[:id])
    unless food.user_id == current_user.id
      redirect_to foods_path
    end
  end
end
