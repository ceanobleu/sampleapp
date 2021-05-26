class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :like]
  before_action :correct_user, only: :destroy
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil? || request.referrer == microposts_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end
  
  def like
    @micropost = Micropost.find(params[:id])
    p @micropost.likes
    puts "------11"
    puts "asdfasdfasd"
    
    # if @micropost.who_liked.nil?
    #   puts "asdfasdf"
    #   @micropost.who_liked = []
    #   @micropost.save
    # end
    
    # puts "------2"
    # p @micropost
    # if @micropost.who_liked.include? current_user.id
    #   flash[:warning] = "You have already liked this post"
    # else
    #   @micropost.who_liked << current_user.id
    #   @micropost.likes += 1
    # end
  end
    
  
  private 
  
    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
