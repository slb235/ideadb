Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IndexView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/ideas/index"]
  itemView: Ideadb.Views.Ideas.IdeaView
  itemViewContainer: "#ideas"
  filter_settings: {}

  initialize: () ->
    Ideadb.Application.vent.on 'add_filter', (new_filter) =>
      if new_filter.tag
        @filter_settings.tag = [] unless @filter_settings.tag
        @filter_settings.tag.push (new_filter.tag)

      @filter_settings.title = new_filter.title if new_filter.title?
      @filter_changed()

    Ideadb.Application.vent.on 'remove_filter', (remove) =>
      if remove.tag
        @filter_settings.tag = _.without @filter_settings.tag, remove.tag
        @filter_changed()

    Ideadb.Application.vent.on 'reset_filter', () =>
      @filter_settings = {}
      @filter_changed()
  

  filter_changed: () ->
    Ideadb.Application.vent.trigger 'filter_changed', @filter_settings
    @render()  

  filter: (item) =>
    item_good = true

    if @filter_settings.title
      item_good = false if item.get('title').toLowerCase().indexOf(@filter_settings.title.toLowerCase()) == -1
        
    if @filter_settings.tag
      _.each @filter_settings.tag, (tag) ->
        item_good = false unless _.contains (item.attributes.tags.map (t) -> t.name), tag

    return item_good

