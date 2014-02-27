class LocalController < ApplicationController
  #layout 'local'

  def index
    @data = "A whole lot of stuff from the local#index route"
  end

end
