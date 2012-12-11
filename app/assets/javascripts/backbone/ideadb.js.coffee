#= require_self
#= require_tree .
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

Backbone.Marionette.CollectionView.prototype.addChildView = (item, collection, options) ->
  filter = @.options.filter || @.filter
  if filter and !filter(item)
    return
  this.closeEmptyView()
  ItemView = this.getItemView()
  @.addItemView item, ItemView, options.index

Backbone.Marionette.CollectionView.prototype.showCollection = () ->
  filter = @.options.filter || @.filter
  that = @
  ItemView = @.getItemView()
  @.collection.each (item, index) ->
    if filter and !filter(item)
      return
    that.addItemView item, ItemView, index

window.Ideadb =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Config: {}
  Application: new Backbone.Marionette.Application()

window.Ideadb.Application.addInitializer (options) ->
  window.Ideadb.Config = options.config
  window.router = new Ideadb.Routers.IdeasRouter({ideas: options.ideas});
  Backbone.history.start();

  #collab = () ->
  #  window.Ideadb.Application.vent.trigger('update_ideas')

  #setInterval collab, 2000 

window.Ideadb.Application.addRegions
  mainRegion: "#ideas"
  addRegion: "#addidea"
  tagRegion: "#tagfilter"
  
