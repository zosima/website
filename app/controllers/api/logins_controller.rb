class Api::LoginsController < ApplicationController
  protect_from_forgery with: :null_session

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

  def show
    puts "THE PARAM IS: " + params[:foo]
    render json: {:foo => "Hello"}
  end
end
