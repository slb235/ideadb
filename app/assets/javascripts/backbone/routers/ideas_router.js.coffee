class Ideadb.Routers.IdeasRouter extends Backbone.Router
  initialize: (options) ->
    @ideas = new Ideadb.Collections.IdeasCollection()
    
    # Collaboartion for now
    
    @addView = new Ideadb.Views.Ideas.AddView
      collection: @ideas
    @tagView = new Ideadb.Views.Ideas.TagView
    @filterView = new Ideadb.Views.Ideas.FilterView
    @ideas.reset options.ideas


    #routes:
    #"index"    : "index"
    #".*"       : "index"

    #index: ->
    @view = new Ideadb.Views.Ideas.IndexView
      collection: @ideas

    window.Ideadb.Application.mainRegion.show(@view)
    window.Ideadb.Application.addRegion.show(@addView)
    window.Ideadb.Application.tagRegion.show(@tagView)
    window.Ideadb.Application.filterRegion.show(@filterView)
