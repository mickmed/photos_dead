class PhotosController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate, except: [:index, :show]
  before_action :random_photos, :except => [:create, :update, :destroy, :show]
  before_action :random_messages 
  before_action :categories

  def index
    session.delete(:category_id)
    session.delete(:category)
    session.delete(:photos)
    session.delete(:abc)
    session.delete(:color)
    session.delete(:hard_cat)
    
    
      
      
    # @messages.each do |message|
      # message.message
      # @messages = [message.message] 
    # end
#     
    @message = @messages.fetch(0)
    
    
    @count = Photo.all.count.to_s
    
    
    if @message == Message.find_by(id: 1).message
      @message = @message 
    elsif @message == Message.find_by(id: 2).message
      @message =   @count + ' ' + @message 
    elsif @message == Message.find_by(id: 3).message
      @message =  @count + ' ' + @message
    end
    
 
    case
    when params[:category] == 'random'
      session[:category] = params[:category]
    when params[:category] == 'abc'
      @photos = Photo.all.order('title asc').paginate(:page => params[:page], :per_page => 6)
      session[:category] = params[:category]
    when params[:category] == 'newest'
      @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order('date_taken desc').paginate(:page => params[:page], :per_page => 6)
      session[:category] = params[:category]
    when params[:category] == 'oldest'
      @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order('date_taken asc').paginate(:page => params[:page], :per_page => 6)
      session[:category] = params[:category]
    else params[:category_id]
      @photos = Photo.where(categories: {id: params[:category_id]}).includes(:categories).order('date_taken asc').paginate(:page => params[:page], :per_page => 6)
      session[:category] = Category.find(params[:category_id])
      session[:category_id] = session[:category].id
    end

    if session[:category]
      session[:color] = 'green'
      if session[:category] != 'random'
        session[:current_page] = @photos.current_page
      end
    end 
    
    @ogtitle = "nyc snaps"
    
    if session[:category_id]
      session[:current_page] = @photos.current_page
      @ogtitle = session[:category].name 
    end
    
    session[:p] = @photos
    
    @ogphoto = @photos.shuffle[1].picture 
    
    
    
    
   
  end


  def show
    @photo = Photo.find(params[:id])
    @photo_categories = @cats.where(photos: {id: params[:id]}).includes(:photos)
    @current_cat = session[:category_id]
    @photos = session[:p]
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
    @fullscreen_photos = @fullscreen_photos.paginate(:page => params[:page], :per_page => 6)
  
    session[:photos] = @photos
    
    
    
    
    
    
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
  
  def random_photos
    if Rails.env.production?
      @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RAND()").limit(6)
    else
      @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RANDOM()").limit(6)
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
end
  
