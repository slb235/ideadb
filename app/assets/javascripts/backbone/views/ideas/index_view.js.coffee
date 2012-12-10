Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IndexView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/ideas/index"]
  itemView: Ideadb.Views.Ideas.IdeaView
  itemViewContainer: "ul"
  filter_settings: {}

  initialize: () ->
    window.Ideadb.Application.vent.on 'filter_ideas', (filter_settings) =>
      @filter_settings = filter_settings
      @render()

  filter: (item) =>
    if @filter_settings.tag
      return _.contains (item.attributes.tags.map (t) -> t.name), @filter_settings.tag
    return true

