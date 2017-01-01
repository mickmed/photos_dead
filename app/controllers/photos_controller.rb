class PhotosController < ApplicationController
  impressionist :actions=>[:show,:index]
  require 'will_paginate/array'
  before_action :authenticate, except: [:index, :show]
  before_action :random_messages 
  before_action :categories


  def index
    
    
    session.delete(:category_id)
    session.delete(:category)
    session.delete(:photos)
    session.delete(:abc)
    session.delete(:color)
    session.delete(:hard_cat)
    session.delete(:category_name)
    # ahoy.track "Home Views", title: "Home page viewed"
    # @home_views = Ahoy::Event.where(name: "Home Views").count
    
    
    
    @imp=Impression.all.where(action_name: "index").count.to_i
   
   
    
    
    @count = Photo.all.count.to_s
    
    
    
 
    if params[:category] 
      
        if params[:category] == 'favorites'
          
           @photos = Photo.all.joins(:impressions).group('photos.id').order('count(photos.id) desc').paginate(:page => params[:page], :per_page => 60) 
           @photos = Photo.select("photos.id, title, picture, count(impressions.impressionable_id) AS listens_count").
    joins("LEFT OUTER JOIN impressions ON impressions.impressionable_id = photos.id AND impressions.impressionable_type = 'Photo'").group("photos.id").order("listens_count DESC").paginate(:page => params[:page], :per_page => 60)

          
        end
        
        if params[:category] == 'newest'
           newest
          
       
           @photo_flick = photo_flick_newest
        end
        session[:category] = params[:category]
        session[:category_name] = params[:category]
    
    else params[:category_id]
        photo_category
        session[:category] = Category.find(params[:category_id])
        session[:category_id] = session[:category].id
        session[:category_name] = session[:category].name
        @photo_flick = photo_flick_category
    end
    
    
    if session[:category] && session[:category] != 'random'
        session[:current_page] = @photos.current_page
    end
    session[:photo_flick] = @photo_flick
    session[:color] = 'green'

    
    @ogphoto = @photos.shuffle[1].picture 
    @ogtype = "website"
    @about_message = @messages.shuffle[1].message
    @ogtitle = "nyc snaps"
    
  
  end


  def show
    @photos = session[:photo_flick]
    @photo = Photo.find(params[:id])
  
    
    
    @photos.each_with_index do |(photo, key, value), index| 
        "#{index}: #{key} => #{value}" + photo.id.to_s 
        #IF SELECTED PHOTO ID MATCHES ID OF PHOTO IN ARRAY @PHOTOS
         if @photo.id == photo.id 
             "#{index}: #{key} => #{value}" + photo.id.to_s
             #THEN SET @INDEX TO THE THE NEXT INDEX IN THE ARRAY 
             @indexnext = index + 1
             
         end 
         #SELECT NEXT IN ARRAY
         if index == @indexnext 
             @photonext = photo.id 
         end 
         
         if !Photo.exists?(@photonext) 
             @photonext = @photo.id
         end
    end 
    
    
    
    @photos.reverse.each_with_index do |(photo, key, value), index| 
          "#{index}: #{key} => #{value}" + photo.id.to_s 
          #IF SELECTED PHOTO ID MATCHES ID OF PHOTO IN ARRAY @PHOTOS
           if @photo.id == photo.id 
               "#{index}: #{key} => #{value}" + photo.id.to_s
               #THEN SET @INDEX TO THE THE NEXT INDEX IN THE ARRAY 
               @indexback = index+1
           end 
           #SELECT NEXT IN ARRAY
           if index == @indexback 
               @photoback = photo.id 
           end 
           if !Photo.exists?(@photoback) 
               @photoback = @photo.id
           end
     end   
    
  
    
    
    
    
 
    @photo_categories = @cats.where(photos: {id: params[:id]}).includes(:photos)
    @current_cat = session[:category_id]
    
    
    
    @current_page = session[:current_page]
    @ogtitle = @photo.description
    @ogphoto = @photo.picture.url
    @message = @messages.shuffle[1].message
    
    @i = @photos.index(@photo)
    @i = @i.to_i
    @from_id = @photos[@i..-1]
    @i = @i-1
    
    @to_id = @photos[0..@i]
    @i = @i+2
    
    @fullscreen_photos = @from_id + @to_id
    @fullscreen_photos = @fullscreen_photos.paginate(:page => params[:page], :per_page => 200)
  
    session[:photos] = @photos
    
   
    @messages.each do |message|
      message.message
      @messages = [message.message] 
    end
    
    @message = @messages.fetch(0)
    
    
    @count = Photo.all.count.to_s
    
    
    if @message == Message.find_by(id: 1).message
      @message = @message 
     
    elsif @message == Message.find_by(id: 2).message
      @message =   @count + ' ' + @message 
    elsif @message == Message.find_by(id: 3).message
      @message =  @count + ' ' + @message
    end
    
     @ogtitle = "nyc snaps"
     @ogtype = "article"
     @about_message = Message.find_by(id: 1).message
    
  end
  
  def new
    @photo_new = Photo.new
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
    @photo_edit = Photo.find(params[:id])
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
  
  def random_messages
    if Rails.env.production?
      @messages = Message.all.order("RAND()").limit(6)
    else
      @messages = Message.all.order("RANDOM()").limit(6)
    end
  end
  

  
  def categories
    @cats = Category.where.not(id: 1)
  end
  
  def authenticate
    @shoonga = authenticate_or_request_with_http_basic do |username, password|
        username == "we8vds" && password == "4vght"
    end
  end
  def newest
    @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order('date_taken desc').paginate(:page => params[:page], :per_page => 6)
  end
  
  def photo_category
     @photos = Photo.where(categories: {id: params[:category_id]}).includes(:categories).order('date_taken desc').paginate(:page => params[:page], :per_page => 6)
  end

  
  
  def photo_flick_newest
    Photo.all.where.not(categories: {id: 1}).includes(:categories).order('date_taken desc')
  end
  
  def photo_flick_category
     Photo.where(categories: {id: params[:category_id]}).includes(:categories).order('date_taken desc')
  end
end
  
