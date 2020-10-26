class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:success] = "The post was created!"
            redirect_to @post    
        else 
             render ‘new’
        end 
    end
    
    def edit
    end

    def update
        if @post.update(post_params)
            flash[:success] = "Update successful"
             redirect_to @post
        else
             render ‘edit’
        end
   end

   def destroy
    @post.destroy
    flash[:success] = "Post destroyed"
    redirect_to root_path
end

    private

    def post_params
        params.require(:post).permit(:title, :content, :category_id)
   end

   def find_post
        @post = Post.find(params[:id])
   end
end
