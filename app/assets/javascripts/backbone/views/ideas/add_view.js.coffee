Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.AddView extends Backbone.View
  template: JST["backbone/templates/ideas/add"]

  tagName: "div"
  className: "iwell"

  events:
    'keypress #new_idea_tags': 'onTagKeyPress'
    'click .rm-tag': 'onTagRemove'

  initialize: () ->
    @known_tags = []
    @add_tags = []

    window.Ideadb.Application.vent.on 'taglist_update', (taglist) =>
      @known_tags = taglist

  render: () ->
    idea_title = ''
    idea_title = @.$('#new_idea_title').val() if @.$('#new_idea_title')

    @.$el.html @template(add_tags: @add_tags)
    @.$('#new_idea_title').val idea_title

    @.$('#new_idea_tags').typeahead
      source: (query) =>
        return @known_tags.filter (t) -> t.toLowerCase().indexOf(query.toLowerCase()) != -1

  onTagKeyPress: (e) ->
    if e.keyCode == 13
      val = @.$('#new_idea_tags').val().trim()
      if val.length
        unless _.contains @add_tags, val
          @add_tags.push val
          @render()
          @.$('#new_idea_tags').focus()
      else
        @onAddIdea()

  onTagRemove: (e) ->
    e.preventDefault()
    @add_tags = _.reject @add_tags, (tag) -> tag == $(e.target).data('tag')
    @render()

  onAddIdea: (e) ->
    tags = _.map @add_tags, (t, i) ->
      id: i
      name: t
    @collection.create
      title: @.$('#new_idea_title').val()
      tags: tags
      user: window.Ideadb.Config.current_user
    @.$('#new_idea_title').val('')
    @add_tags = []
    @render()


