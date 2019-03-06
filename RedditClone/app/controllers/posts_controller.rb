class PostsController < ApplicationController 

    before_action :ensure_author, only: [:edit, :update]

    def new
        @post = Post.new
    end

    def create 
        @post = current_user.posts.new(post_params)
        if @post.save 
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find_by(id: params[:id])
    end

    def edit 
        @post = Post.find_by(id: params[:id])
    end

    def update 
        @post = current_user.posts.find_by(id: params[:id])
        if @post 
            if @post.update_attributes(post_params)
                redirect_to post_url(@post)
            else
                flash[:errors] = @post.errors.full_messages 
                render :edit
            end
        else 
            flash[:errors] = ["You cannot edit this post"]
            redirect_to post_url(@post)
        end
    end

    def destroy
        @post = current_user.posts.find_by(id: params[:id])
        if @post 
            @post.destroy 
            redirect_to sub_url(@post.sub_id)
        else 
            flash[:errors] = ["You cannot delete this post"]
            redirect_to post_url(@post)
        end
    end

    private 

    def ensure_author 
        @post = Post.find_by(id: params[:id])
        unless current_user.id == @post.author_id
            flash[:errors] = ["You cannot edit this post!"]
            redirect_to post_url(@post) 
        end
    end

    def post_params 
        params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end
end 