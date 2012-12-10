class Ideadb.Routers.IdeasRouter extends Backbone.Router
  initialize: (options) ->
    @ideas = new Ideadb.Collections.IdeasCollection()
    
    # Collaboartion for now
    
    @addView = new Ideadb.Views.Ideas.AddView
      collection: @ideas
    @ideas.reset options.ideas


  routes:
    "new"      : "newIdea"
    "index"    : "index"
    ".*"        : "index"

  index: ->
    @view = new Ideadb.Views.Ideas.IndexView(collection: @ideas)

    window.Ideadb.Application.mainRegion.show(@view)
    window.Ideadb.Application.addRegion.show(@addView)
