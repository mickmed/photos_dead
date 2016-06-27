class PhotosController < ApplicationController

before_action :authenticate, except: [:index, :show]
before_action :random, :except => [:create, :update, :destroy, :show]


def authenticate
 @shoonga = authenticate_or_request_with_http_basic do |username, password|
  username == "trevor" && password == "trevor"
 end
end


def index
  
 
  
  
  
@cats = Category.where.not(id: 1)
@photos = Photo.where.not(categories: {id: 1}).includes(:categories).order("RANDOM()").limit(5)
 
 if params[:abc] == 'abc'
  @photos = Photo.all.order('title asc').paginate(:page => params[:page], :per_page => 5)
 end
  
 if params[:category_id]
  @photos = Photo.where(categories: {id: params[:category_id]}).includes(:categories).paginate(:page => params[:page], :per_page => 5)
 end
 
 
 
#Rails.cache.write("phot",@photos)  




session[:p] = @photos
end


def show
 #@photos = Rails.cache.read("phot",@photos)   
 @photos = session[:p]

 @cats = Category.where.not(id: 1)
 @photo = Photo.find(params[:id])
 photo_id = @photo.id
 #@photos=@photos.unshift(@photo)
 @i = @photos.index(@photo)
#render :text => @photos

#render :text => @photos

 @i = @i.to_i
 @from_id = @photos[@i..-1]
 @i = @i-1
 @to_id = @photos[0..@i]
 
 @photos = @from_id + @to_id
 #render :text => @from_id
 #render :text => @photos

end
    
 def new
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
 @photos = Photo.all
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
 
 def random
  if Rails.env.production?
   @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RAND()").limit(5).paginate(:page => params[:page], :per_page => 5)
  else
   @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RANDOM()").limit(5).paginate(:page => params[:page], :per_page => 5)
  end 
 end
end
