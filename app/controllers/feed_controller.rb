require 'instagram'
# require 'open-uri'
# require 'openssl'
require 'kaminari'

class FeedController < ApplicationController 
  
  def index    
    if session[:access_token] 
      redirect_to :controller=>'feed', :action=>'home'
    end
  end
    
  def home
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user

    # logger.debug "Max ID is #{session[:maxid]}."
    # logger.debug "Min ID is #{session[:minid]}."

    # @recent = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 6})['data']


    # if session[:maxid] == ''
    #   @recent = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 6})['data']
    # else
    #   @recent = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 6, :max_id => session[:maxid]})['data']
    # end

    @recent_unpaged = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 60})['data']

    @recent = Kaminari.paginate_array(@recent_unpaged).page(params[:page]).per(5)

    # session[:previousminid] = session[:minid]
    # session[:previousmaxid] = session[:maxid]
    # session[:minid] = @recent.first.id.split("_")[0].to_i
    # session[:maxid] = @recent.last.id.split("_")[0].to_i
  end


  def back
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    #if @maxid is blank
    @recent = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 6, :min_id => session[:minid], :max_id => session[:previousminid]})['data']
    # @recent = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 6, :max_id => session[:maxid], :min_id => session[:minid]})['data']

    #Grabs the id of the bottom-most picture from the set of 60 and converts it to an integer.  We use this value
    #to call the next 60 photos that have an id less than or equaled to the @maxid value.
    # session[:previousminid] = session[:minid]
    # session[:previousmaxid] = session[:maxid]
    # session[:minid] = @recent.first.id.split("_")[0].to_i
    # session[:maxid] = @recent.last.id.split("_")[0].to_i
  end

  def show
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @media = client.media_item(params[:id])

  end

  def recent
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @user_recent_media = client.tag('Chitown')
  end
  
  
end