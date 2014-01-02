class Api::LoginsController < ApplicationController
  protect_from_forgery with: :null_session

  include ApiAuth
  before_action :check_authentication, :except => [:create, :destroy]

  def create
    unless params[:access_token]
      head :bad_request
      return
    end
    
    login = nil
    begin
      login = Login.get_via_google_token params[:access_token]
    rescue
      head :unauthorized
      return
    end

    ret = login.generate_token
    render :json => {
      :token => ret.token_text,
      :expires_at => ret.expires_at
    }
  end

  def destroy
    unless params[:token]
      head :bad_request
      return
    end

    t = token.find_by_token_text params[:token]
    t.destroy if t

    head :ok
  end

  def current
    render :json => {
      :id => @current_user.google_id,
      :display_name => @current_user.display_name,
      :url => @current_user.url,
      :image_url => @current_user.image_url,
    }
  end
end
