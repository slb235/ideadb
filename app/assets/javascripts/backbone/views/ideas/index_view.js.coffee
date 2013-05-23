Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IndexView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/ideas/index"]
  itemView: Ideadb.Views.Ideas.IdeaView
  itemViewContainer: "#ideas"
  filter_settings: {}

  events:
    'click .show_all': 'show_all_comments'
    'click .hide_all': 'hide_all_comments'

  ui:
    'title': 'h3'

  initialize: () ->
    Ideadb.Application.vent.on 'add_filter', (new_filter) =>
      if new_filter.tag
        @filter_settings.tag = [] unless @filter_settings.tag
        @filter_settings.tag.push new_filter.tag

      if new_filter.withouttag
        @filter_settings.withouttag = [] unless @filter_settings.withouttag
        @filter_settings.withouttag.push new_filter.withouttag

      if new_filter.user
        @filter_settings.user = [] unless @filter_settings_user
        @filter_settings.user.push new_filter.user

      @filter_settings.title = new_filter.title if new_filter.title?
      @filter_changed()

    Ideadb.Application.vent.on 'remove_filter', (remove) =>
      if remove.tag
        @filter_settings.tag = _.without @filter_settings.tag, remove.tag
        @filter_changed()
      if remove.withouttag
        @filter_settings.withouttag = _.without @filter_settings.withouttag, remove.withouttag
        @filter_changed()
      if remove.user
        @filter_settings.user = _.without @filter_settings.user, remove.user
        @filter_changed()

    Ideadb.Application.vent.on 'reset_filter', () =>
      @filter_settings = {}
      @filter_changed()

    Ideadb.Application.vent.on 'sorting_changed', () =>
      @render()

    @collection.on 'add', () =>
      @render()

  onRender: () =>
    $.livestamp.update()
    @ui.title.text @collection.models.filter(@filter).length + ' ideas'

  filter_changed: () ->
    Ideadb.Application.vent.trigger 'filter_changed', @filter_settings
    @render() 

  filter: (item) =>
    item_good = true

    if @filter_settings.title and @filter_settings.title.length
      item_good = false if item.get('title').toLowerCase().indexOf(@filter_settings.title.toLowerCase()) == -1
        
    if @filter_settings.tag and @filter_settings.tag.length
      _.each @filter_settings.tag, (tag) ->
        item_good = false unless _.contains (item.attributes.tags.map (t) -> t.name), tag

    if @filter_settings.withouttag and @filter_settings.withouttag.length
      _.each @filter_settings.withouttag, (tag) ->
        item_good = false if _.contains (item.attributes.tags.map (t) -> t.name), tag

    if @filter_settings.user and @filter_settings.user.length
      item_good = false unless _.contains @filter_settings.user, item.attributes.user.name

    return item_good

  show_all_comments: () ->
    $('.icon-comment-alt').trigger 'click'

  hide_all_comments: () ->
    $('.icon-comments-alt').trigger 'click'


