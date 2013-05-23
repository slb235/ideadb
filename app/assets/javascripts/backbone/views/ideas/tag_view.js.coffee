Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.TagView extends Backbone.View
  template: JST["backbone/templates/ideas/tags"]

  tagName: "div"
  className: "iwell"

  events: 
    'click .tag-link': 'tagfilter'
    'click .without-tag-link': 'without_tagfilter'
    'click .rename-tag': 'rename_tag'
    
  initialize: () ->
    @known_tags = []

    window.Ideadb.Application.vent.on 'dynamic_tags', (wtags) =>
      @known_tags = wtags
      @render()

  render: () ->
    sorted = _.sortBy _.pairs(@known_tags), (t) -> -1 * t[1]
    @.$el.html @template tags: sorted

  tagfilter: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'add_filter', 
      tag: $(e.target).data('tag')

  without_tagfilter: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'add_filter', 
      withouttag: $(e.target).data('tag')

  rename_tag: (e) ->
    e.preventDefault()
    new_tag = window.prompt('Rename Tag in', $(e.target).parent().data('tag'))
    if new_tag != null and new_tag.length > 0
      window.location = 'rename_tag?' + $.param
        from: $(e.target).parent().data('tag')
        to: new_tag


