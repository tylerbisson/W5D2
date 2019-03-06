class CommentsController < ApplicationController 

     def new
        @comment = Comment.new
     end

     def create 
        @comment = current_user.comments.new(comment_params)
        if @comment.save 
            redirect_to post_url(@comment.post_id)
        else 
            flash[:errors] = @comment.errors.full_messages 
            render :new
        end
     end    

     def show 
        @comment = Comment.find_by(id: params[:id])
     end

     private
     def comment_params 
        params.require(:comment).permit(:content, :post_id, :parent_comment_id)
     end
end