Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.TagView extends Backbone.View
  template: JST["backbone/templates/ideas/tags"]

  tagName: "div"
  className: "well"

  events: 
    'click .tag': 'tagfilter'
    'click .clearfilter': 'reset'

  initialize: () ->
    @known_tags = []

    window.Ideadb.Application.vent.on 'taglist_update', (taglist) =>
      @known_tags = taglist
      @render()

  render: () ->
    @.$el.html @template tags: @known_tags

  tagfilter: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'filter_ideas', 
      tag: $(e.target).data('tag')

  reset: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'filter_ideas', {}
