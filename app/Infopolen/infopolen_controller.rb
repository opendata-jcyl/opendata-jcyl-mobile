require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class InfopolenController < Rho::RhoController
  include BrowserHelper

  # GET /Infopolen
  def index
    response = Rho::AsyncHttp.get(:url => Rho::RhoConfig.REST_BASE_URL + "info_polens.json",
      :headers => {"Content-Type" => "application/json"})
    @infopolens = response["body"]

    render :back => '/app'
  end

  # GET /Infopolen/{1}
  def show
    id = @params['id']
    
    response = Rho::AsyncHttp.get(:url => Rho::RhoConfig.REST_BASE_URL + "info_polens/" + id +".json",
      :headers => {"Content-Type" => "application/json"})

    @infopolen = response["body"]
  end

end
