class Api::LoginsController < ApplicationController
  def show
    puts "THE PARAM IS: " + params[:foo]
    render json: {:foo => "Hello"}
  end
end
