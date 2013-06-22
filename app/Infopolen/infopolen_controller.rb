require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class InfopolenController < Rho::RhoController
  include BrowserHelper

  # GET /Infopolen
  def index
    response = Rho::AsyncHttp.get(:url => Rho::RhoConfig.REST_BASE_URL + "info_polens/mapa.json",
      :headers => {"Content-Type" => "application/json"})
    @infopolens = response["body"]

    annotations = []

    @infopolens.each do |infopolen|   
      annotations << {
        :longitude => infopolen['coordenadas'][0],
        :latitude => infopolen['coordenadas'][1],
        :title => infopolen['_id'],
        :subtitle => infopolen['fecha'],
        :image => '/public/images/anemometer_mono.png', 
        :image_x_offset => 8, 
        :image_y_offset => 32, 
        :url => '/app/Infopolen/show?station=' + infopolen['_id'] + '&date=' + infopolen['fecha'].to_s
      }
    end

    map_params = {
     :provider => 'OSM',
     :settings => {:map_type => "hybrid", :region => [Rho::RhoConfig.LAT_DEFAULT, Rho::RhoConfig.LON_DEFAULT, 2.4, 2.4],
                   :zoom_enabled => true, :scroll_enabled => true, :shows_user_location => false},
     :annotations => annotations
    }
    MapView.create map_params

  end

  # GET /Infopolen/{1}
  def show
    station = @params['station']
    date = @params['date']
    
    response = Rho::AsyncHttp.get(:url => Rho::RhoConfig.REST_BASE_URL + 'info_polens/' + station + '/' + date.to_s + '/estaciones.json',
      :headers => {"Content-Type" => "application/json"})

    @infopolen = response["body"]
  end

end
