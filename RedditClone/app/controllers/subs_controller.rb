class SubsController < ApplicationController 
    before_action :ensure_moderator, only: [:edit, :update]
    before_action :ensure_logged_in

    def new
        @sub = Sub.new 
    end

    def show
        @sub = Sub.find_by(id: params[:id])
    end

    def create 
        @sub = current_user.subs.new(sub_params)
        if @sub.save 
            redirect_to sub_url(@sub)
        else 
            flash[:errors] = @sub.errors.full_messages 
            render :new 
        end 
    end 

    def index 
        @subs = Sub.all
    end 

    def update 
        @sub = current_user.subs.find_by(id: params[:id])
        if @sub 
            if @sub.update(sub_params)
                redirect_to sub_url(@sub)
            else 
                flash.now[:errors] = @sub.errors.full_messages 
                render :edit 
            end
        else 
            flash.now[:errors] = ["You are not the moderator for this sub"]
            redirect_to sub_url(@sub)
        end 
    end 

    def edit 
        @sub = Sub.find_by(id: params[:id])
    end 

    private 
    def ensure_moderator    
        @sub = Sub.find_by(id: params[:id])
        unless current_user.id == @sub.moderator_id
            flash[:errors] = ["You are not the moderator for this sub"]
            redirect_to sub_url(@sub) 
        end
    end

    def sub_params 
        params.require(:sub).permit(:title, :description)
    end 
end