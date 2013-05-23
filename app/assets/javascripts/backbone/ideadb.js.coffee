#= require_self
#= require_tree .
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

Backbone.Marionette.CollectionView.prototype.addChildView = (item, collection, options) ->
  #filter = @options.filter || @filter
  #if filter and !filter(item)
  #  return
  #this.closeEmptyView()
  #ItemView = this.getItemView()
  #@addItemView item, ItemView, options.index

Backbone.Marionette.CollectionView.prototype.showCollection = () ->
  filter = @options.filter || @filter
  sort = @options.sort || @sort || (collection) -> collection
  that = @
  ItemView = @getItemView()
  window.collection = @collection

  filteredCollection = []
  _.each sort(@collection.models), (item, index) ->
    if filter and !filter(item)
      return

    filteredCollection.push(item)
    that.addItemView item, ItemView, index


  if @constructor.name == "IndexView"

    flat_tags = _.flatten _.map filteredCollection, (idea) ->
      _.map idea.attributes.tags, (tag) ->
        tag.name

    uniq_tags = _.unique flat_tags
    weighted_tags = {}

    _.each flat_tags, (tag) ->
      if weighted_tags[tag]
        weighted_tags[tag]++
      else
        weighted_tags[tag] = 1

    window.Ideadb.Application.vent.trigger 'dynamic_tags', weighted_tags




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
  filterRegion: "#filter"
  sortingRegion: "#sorting"
  
