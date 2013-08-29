class Ideadb.Routers.IdeasRouter extends Backbone.Router
  initialize: (options) ->
    @ideas = new Ideadb.Collections.IdeasCollection()
    
    # Collaboartion for now
    
    @addView = new Ideadb.Views.Ideas.AddView
      collection: @ideas
    @tagView = new Ideadb.Views.Ideas.TagView
    @filterView = new Ideadb.Views.Ideas.FilterView
    @ideas.reset options.ideas


    @view = new Ideadb.Views.Ideas.IndexView
      collection: @ideas

    window.Ideadb.Application.mainRegion.show(@view)
    window.Ideadb.Application.addRegion.show(@addView)
    window.Ideadb.Application.tagRegion.show(@tagView)
    window.Ideadb.Application.filterRegion.show(@filterView)

    if window.location.hash
      match = window.location.hash.match /#\d+/
      if match
        $('#search_query').val(window.location.hash)
        $('#search_query').trigger('keyup')