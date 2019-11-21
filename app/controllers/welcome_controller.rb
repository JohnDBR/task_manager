# This controller has the health enpoint!
class WelcomeController < ActionController::Base
  def welcome
    url_helper = ApplicationController.default_url_options
    render url_helper[:env].to_s
  end
end
