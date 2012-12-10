Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IndexView extends Backbone.View
  template: JST["backbone/templates/ideas/index"]

  initialize: () ->
    @options.ideas.bind('reset', @addAll)

  addAll: () =>
    @options.ideas.each(@addOne)

  addOne: (idea) =>
    view = new Ideadb.Views.Ideas.IdeaView({model : idea})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(ideas: @options.ideas.toJSON() ))
    @addAll()

    return this
