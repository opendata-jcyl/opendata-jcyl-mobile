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

  def map_it
    map_params = {
     :provider => 'OSM',
     :settings => {:map_type => "hybrid",:region => [@params['latitude'], @params['longitude'], 0.2, 0.2],
                   :zoom_enabled => true,:scroll_enabled => true,:shows_user_location => false},
     :annotations => [{
                      :latitude => @params['latitude'], 
                      :longitude => @params['longitude'], 
                      :title => @params['station'], 
                      :subtitle => @params['date']
                      }]
    }
    MapView.create map_params

    redirect :action => :index
  end

end
