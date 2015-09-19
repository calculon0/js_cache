class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    sites = []
    App.all.each do |a|
      sites.push({'name': a.name, 'urls': [a.url] } )
    end
    gon.sites = sites
  end

  def visited
    params.delete('controller')
    params.delete('action')
    params.keys.each do |app_key|
      if current_user.apps.where(name: app_key).empty?
        current_user.apps << App.where(name: app_key).first
      end
    end
    visited = current_user.apps.map { |x| x.name }
    not_visited = App.all.map{ |x| x.name } - current_user.apps.map { |x| x.name }

    render json: {"visited": visited, "not_visited": not_visited}
  end
end
