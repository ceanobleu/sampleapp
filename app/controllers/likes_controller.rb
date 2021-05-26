class LikesController < ApplicationController
  before_action :logged_in_user
  
  def create
    #user = User.find(params[:followed_id])
    @micropost = Micropost.find(params[:id])
    if Like.find_by(micropost_id: @micropost.id, user_id: current_user.id) == nil
      @like = Like.new(micropost_id: @micropost.id, user_id: current_user.id)
      @like.save

      flash[:success] = "You liked this post!"
    else
      @like = Like.find_by(micropost_id: @micropost.id, user_id: current_user.id)
      @like.destroy
      
      flash[:warning] = "You unliked this post."
    end
    redirect_back(fallback_location: root_path)
  end
  

  def destroy
  end
end
