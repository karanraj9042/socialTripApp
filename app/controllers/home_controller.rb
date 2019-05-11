#Controller for home page.
class HomeController < ApplicationController
  require 'my_logger'
  
  def index
  logger = MyLogger.instance
  logger.logInformation("Home Page Loaded.")
  end
end
