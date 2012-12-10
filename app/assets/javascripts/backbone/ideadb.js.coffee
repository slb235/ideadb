#= require_self
#= require_tree .
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Ideadb =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Config: {}
  Application: new Backbone.Marionette.Application()

window.Ideadb.Application.addInitializer (options) ->
  window.Ideadb.Config = options.config

window.Ideadb.Application.addInitializer (options) ->
  window.router = new Ideadb.Routers.IdeasRouter({ideas: options.ideas});
  Backbone.history.start();
  
