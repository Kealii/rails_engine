require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :json, :html, :xml
  protect_from_forgery with: :exception
end
