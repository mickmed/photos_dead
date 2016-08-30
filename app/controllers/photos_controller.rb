class PhotosController < ApplicationController
require 'will_paginate/array'
before_action :authenticate, except: [:index, :show]
#before_action :random, :except => [:create, :update, :destroy, :show]


def authenticate
 @shoonga = authenticate_or_request_with_http_basic do |username, password|
  username == "4vght" && password == "we8vds"
 end
end




def index
 session.delete(:category_id)
 session.delete(:category)
 session.delete(:photos)
 session.delete(:abc)
 session.delete(:color)
 session.delete(:hard_cat)


@cats = Category.where.not(id: 1)



if params[:category] == 'random'
 if Rails.env.production?
   @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RAND()").limit(6)
  else
   @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RANDOM()").limit(6)
  end
  session[:category] = 'random'
  
end

 if params[:category] == 'abc'
  @photos = Photo.all.order('title asc').paginate(:page => params[:page], :per_page => 6)
  session[:category] = 'abc'
 
 end
    
 if params[:category] == 'newest'
  @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order('date_taken desc').paginate(:page => params[:page], :per_page => 6)
  session[:category] = 'newest'
  
  
 end  
 
 
 if params[:category] == 'oldest'
  @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order('date_taken asc').paginate(:page => params[:page], :per_page => 6)
  session[:category] = 'oldest'
  
 end  
 
 
 
 
 if params[:category_id]
   
  @photos = Photo.where(categories: {id: params[:category_id]}).includes(:categories).order('date_taken asc').paginate(:page => params[:page], :per_page => 6)
  session[:category] = Category.find(params[:category_id])
  session[:category_id] = session[:category].id
  
  #session[:current_cat] = @current_cat.id
 end
 
 
 if session[:category]
   session[:color] = 'green'
   if session[:category] != 'random'
    session[:current_page] = @photos.current_page
   end
 end
 
 if session[:category_id] 
    session[:current_page] = @photos.current_page
    # session[:current_page] = @photos.current_page
 end
 
 session[:p] = @photos

end
  


 
 


 #Rails.cache.write("phot",@photos)  
 #@photos=@photos.unshift(@photo) 
 #@photos = Rails.cache.read("phot",@photos)   
 #render :text => @photos
 #render :text => @photos
 #render :text => @from_id
 #render :text => @photos




def show
 @current_cat = session[:category_id]
 @photos = session[:p]
 #@s_photos = Photo.where(categories: {id: @current_cat}).includes(:categories)
 @cats = Category.where.not(id: 1)
 @photo = Photo.find(params[:id])
 #@size = ImageSize.path('public'+ @photo.picture.url).size
 @current_page = session[:current_page]
 
 
 
 
 
 @i = @photos.index(@photo)

 @i = @i.to_i
 @from_id = @photos[@i..-1]
 @i = @i-1
 #@prev=@photos[@i]

 @to_id = @photos[0..@i]
 @i = @i+2
 #@next= @photos[@i]
 
 @fullscreen_photos = @from_id + @to_id
 @fullscreen_photos = @fullscreen_photos.paginate(:page => params[:page], :per_page => 6)
 
 session[:photos] = @photos
 
end
   
     
   
   
   
   
   
    
 def new
   @photos = Photo.all.paginate(:page => params[:page], :per_page => 6)
  @photo_new = Photo.new
  @cats = Category.all
 end
  
 def create
  @photo_new = Photo.new(photo_params)
  if @photo_new.save
   flash[:info] = "saved"
   redirect_to root_url
  else
   render 'new'
  end
end
  
def edit
 @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
 @photo_edit = Photo.find(params[:id])
 @cats = Category.all
end

def update
 @photo = Photo.find(params[:id])
 if @photo.update_attributes(photo_params)
  # Handle a successful update.
  flash[:success] = "Photo updated"
  redirect_to photo_path
 else
  render 'edit'
 end
end
  
def destroy
 Photo.find(params[:id]).destroy
 flash[:success] = "photo deleted"
 redirect_to root_path
end

private

 def photo_params
  params.require(:photo).permit(:title, :description, :picture, :date_taken, category_ids:[])
 end
 # def random
#   
 # end
end
