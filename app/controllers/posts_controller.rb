class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def index
        if params[:category].blank?
            @posts = Post.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @posts = Post.where(category_id: @category_id).order("created_at DESC")
        end
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
        params.require(:post).permit(:title, :content, :category_id, :image)
   end

   def find_post
        @post = Post.find(params[:id])
   end
end
