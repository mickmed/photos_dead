class PhotosController < ApplicationController


before_action :authenticate, except: [:index, :show]


def authenticate
  @shoonga = authenticate_or_request_with_http_basic do |username, password|
    username == "trevor" && password == "trevor"
  end
end



def index
 
 if Rails.env.production?
    @r=Photo.all.order("RAND()")
  else
    @r = Photo.all.order("RANDOM()")
  end
    
 
 
  
  #@r = Photo.all
  #@photos = @r.paginate(:page => params[:page], :per_page => 5)
  
  @cats = Category.all
  
  if params[:abc] == 'abc'
   @photos = Photo.all.order('title asc').paginate(:page => params[:page], :per_page => 5)
  end
  
  
  if params[:category_id]
    #@photos = Photo.joins("inner join categories on photositems.category_id=categories.id").reorder(@sort).where(category_id: params[:category_id]).paginate(page: params[:page])
    
    
    @photos = Photo.where(categories: {id: params[:category_id]}).includes(:categories).paginate(:page => params[:page], :per_page => 30)
   
  end
end

def show
  @r = Photo.all
  @cats = Category.all
  @photo = Photo.find(params[:id])
  #@items = @user.items.paginate(page: params[:page])
  #debugger
end
    
 
 
 
 def new
  @photo = Photo.new
  @cats = Category.all
 end
  
 def create
   
       @photo = Photo.new(photo_params)
    if @photo.save
      
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
   

end
  
  
def edit
  @photo = Photo.find(params[:id])
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

end