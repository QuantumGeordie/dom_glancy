class DomGlancyApplicationController < ApplicationController
  before_filter :get_gem_version

  def get_gem_version
    @gem_version = Gem.loaded_specs['dom_glancy'].version.to_s
    @parent_application_name = Rails.application.class.to_s.split('::').first
  end
end
