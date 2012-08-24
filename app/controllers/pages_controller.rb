class PagesController < ApplicationController
  def about
  @title = "Acerca"
  end

  def contact
  @title = "Contacto"
  end

end
