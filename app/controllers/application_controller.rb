class ApplicationController < ActionController::Base
  def welcome
    render html: 'Welcome to Blogist!'
  end
end
