class Ideadb.Routers.IdeasRouter extends Backbone.Router
  initialize: (options) ->
    @ideas = new Ideadb.Collections.IdeasCollection()
    @ideas.reset options.ideas

  routes:
    "new"      : "newIdea"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newIdea: ->
    @view = new Ideadb.Views.Ideas.NewView(collection: @ideas)
    $("#ideas").html(@view.render().el)

  index: ->
    @view = new Ideadb.Views.Ideas.IndexView(ideas: @ideas)
    $("#ideas").html(@view.render().el)

  show: (id) ->
    idea = @ideas.get(id)

    @view = new Ideadb.Views.Ideas.ShowView(model: idea)
    $("#ideas").html(@view.render().el)

  edit: (id) ->
    idea = @ideas.get(id)

    @view = new Ideadb.Views.Ideas.EditView(model: idea)
    $("#ideas").html(@view.render().el)
