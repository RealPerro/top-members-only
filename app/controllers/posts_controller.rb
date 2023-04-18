class PostsController < ApplicationController
  before_action :authenticate_user!,  except: [:index]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @current_user = current_user
    @post = Post.new
    @post.user_id = @current_user.id
    @post.title = post_params[:title]
    @post.body = post_params[:body]

    if @post.save
      redirect_to @post
    else
      render :new, status: unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end