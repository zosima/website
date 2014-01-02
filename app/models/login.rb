require 'google/api_client'

class Login < ActiveRecord::Base
  has_many :tokens

  def self.get_via_google_token(access_token)
    client = Google::APIClient.new(
      :application_name => "Zosima",
      :application_version => "0.1")

    plus = client.discovered_api("plus")

    client.authorization.client_id = ENV['GPLUS_CLIENT_ID']
    client.authorization.client_secret = ENV['GPLUS_CLIENT_SECRET']
    client.authorization.access_token = access_token

    result = client.execute(:api_method => plus.people.get, :parameters => {:userId => 'me'}).data

    raise "Invalid data" unless result.id

    ret = Login.find_by_google_id result.id
    return ret if ret

    ret = Login.new
    ret.google_id = result.id
    ret.image_url = result.image.url
    ret.display_name = result.display_name
    ret.url = result.url

    ret.save!
    return ret
  end

  def generate_token
    ret = Token.generate
    tokens << ret
    save!
    ret
  end
end
