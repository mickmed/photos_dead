class PostsController < ApplicationController
  def index
    @posts = Post.paginate(page: params[:page], :per_page => 10)
     
    if request.xhr?
     # render :partial=>"post"
    end
  end
end