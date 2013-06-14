require 'rho/rhocontroller'
require 'helpers/browser_helper'

class InfopolenController < Rho::RhoController
  include BrowserHelper

  # GET /Infopolen
  def index
    @infopolens = Infopolen.find(:all)
    render :back => '/app'
  end

  # GET /Infopolen/{1}
  def show
    @infopolen = Infopolen.find(@params['id'])
    if @infopolen
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Infopolen/new
  def new
    @infopolen = Infopolen.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Infopolen/{1}/edit
  def edit
    @infopolen = Infopolen.find(@params['id'])
    if @infopolen
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Infopolen/create
  def create
    @infopolen = Infopolen.create(@params['infopolen'])
    redirect :action => :index
  end

  # POST /Infopolen/{1}/update
  def update
    @infopolen = Infopolen.find(@params['id'])
    @infopolen.update_attributes(@params['infopolen']) if @infopolen
    redirect :action => :index
  end

  # POST /Infopolen/{1}/delete
  def delete
    @infopolen = Infopolen.find(@params['id'])
    @infopolen.destroy if @infopolen
    redirect :action => :index  
  end
end
