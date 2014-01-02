module ApiAuth
  extend ActiveSupport::Concern

  def check_authentication
    t = Token.get params[:access_token]
    unless t
      head :unauthorized
      return false
    end

    @current_user = t.login
  end

  def current_user
    @current_user
  end
end

module ApiAuthAllMethods
  extend ActiveSupport::Concern
  extend ApiAuth

  included do
    before_action :check_authorization
  end
end
