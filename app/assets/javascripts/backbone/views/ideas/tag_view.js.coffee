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

    window.Ideadb.Application.vent.on 'taglist_update', (taglist, wtags) =>
      @known_tags = wtags
      @render()

  render: () ->
    sorted = _.sortBy _.pairs(@known_tags), (t) -> -1 * t[1]
    @.$el.html @template tags: sorted

  tagfilter: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'filter_ideas', 
      tag: $(e.target).data('tag')

  reset: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'filter_ideas', {}
