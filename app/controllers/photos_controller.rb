class PhotosController < ApplicationController
require 'will_paginate/array'
before_action :authenticate, except: [:index, :show]
#before_action :random, :except => [:create, :update, :destroy, :show]


def authenticate
 @shoonga = authenticate_or_request_with_http_basic do |username, password|
  username == "trevor" && password == "trevor"
 end
end


def index
 session.delete(:current_cat) 
 session.delete(:photos) 
 


 
 if Rails.env.production?
   @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RAND()").limit(3)
  else
   @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RANDOM()").limit(3)
  end 
  
  
  
@cats = Category.where.not(id: 1)



 if params[:abc] == 'abc'
  @photos = Photo.all.order('title asc').paginate(:page => params[:page], :per_page => 3)
 end
  
 if params[:category_id]
  @photos = Photo.where(categories: {id: params[:category_id]}).includes(:categories).paginate(:page => params[:page], :per_page => 3)
  
  session[:current_cat] = Category.find(params[:category_id])
  #session[:current_cat] = @current_cat.id
  
 
   session[:current_page] = @photos.current_page
  
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
 @current_cat = session[:current_cat]
 @photos = session[:p]
 @s_photos = Photo.where(categories: {id: @current_cat}).includes(:categories)
 @cats = Category.where.not(id: 1)
 @photo = Photo.find(params[:id])
 #@size = ImageSize.path('public'+ @photo.picture.url).size
 @current_page = session[:current_page]
 
 
 
 
 
 @i = @photos.index(@photo)

 @i = @i.to_i
 @from_id = @photos[@i..-1]
 @i = @i-1
 @prev=@photos[@i]
 @to_id = @photos[0..@i]
 @i = @i+2
 @next= @photos[@i]
 
 @photos = @from_id + @to_id
 @photos = @photos.paginate(:page => params[:page], :per_page => 3)
 
 session[:photos] = @photos
 
end
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
    
 def new
   @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
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
  redirect_to photos_path
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
  params.require(:photo).permit(:title, :description, :picture, category_ids:[])
 end
 # def random
#   
 # end
end
