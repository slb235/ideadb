Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IndexView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/ideas/index"]
  itemView: Ideadb.Views.Ideas.IdeaView
  itemViewContainer: "#ideas"
  filter_settings: {}

  events:
    'click .show_all': 'show_all_comments'
    'click .hide_all': 'hide_all_comments'
    'click .sort': 'sort_change'
    'change select#limit': 'limitselect'    

  ui:
    'title': 'h3'
    'limit': 'select#limit'   
    'sort_buttons': 'i.icon-sorting'

  initialize: () ->
    @reverse = true;
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

    Ideadb.Application.vent.on 'limit_changed', () =>
      @render()

    @collection.on 'add', () =>
      setTimeout @render, 50

    @order = 'date'

  onRender: () =>
    $.livestamp.update()
    filteredCollection = @collection.models.filter(@filter)

    if @limit and @limit < filteredCollection.length
      @ui.title.text "#{@limit} of #{filteredCollection.length} ideas" 
    else
      @ui.title.text "#{filteredCollection.length} ideas" 

    flat_tags = _.flatten _.map filteredCollection, (idea) ->
      _.map idea.attributes.tags, (tag) ->
        tag.name

    uniq_tags = _.unique flat_tags
    weighted_tags = {}

    _.each flat_tags, (tag) ->
      if weighted_tags[tag]
        weighted_tags[tag]++
      else
        weighted_tags[tag] = 1

    window.Ideadb.Application.vent.trigger 'dynamic_tags', weighted_tags

    limit = localStorage.getItem 'limit'
    if limit
      @ui.limit.val limit  

    highlight = () =>
      $("[data-sort=#{@order}]").addClass('active')

    setTimeout highlight, 0

  filter_changed: () ->
    Ideadb.Application.vent.trigger 'filter_changed', @filter_settings
    @render() 

  pre_filter: () ->
    @limit = parseInt(localStorage.getItem('limit')) || 50
    @counter = 0

  after_filter: () ->
    @counter = undefined

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

    if @counter != undefined
      if item_good
        if ++@counter > @limit
          item_good = false            

    return item_good

  show_all_comments: () ->
    $('.icon-comment-alt').trigger 'click'

  hide_all_comments: () ->
    $('.icon-comments-alt').trigger 'click'

  sort: (collection) =>
    collection = _.clone collection

    switch @order
      when 'date' then collection = _.sortBy collection, 'created_at'
      when 'author' then collection = _.sortBy collection, (item) -> item.get('user').name
      when 'shuffle' then collection = _.shuffle collection

    if @reverse
      return collection.reverse()
    else
      return collection


  sort_change: (e) =>
    e.preventDefault()
    window.e = e
    new_sort = $(e.target).data('sort')

    if @order == new_sort
      @reverse = !@reverse
    else
      @order = new_sort
      @reverse = false

    Ideadb.Application.vent.trigger 'sorting_changed'

  limitselect: (e) =>
    localStorage.setItem 'limit', parseInt(@ui.limit.val())
    Ideadb.Application.vent.trigger 'limit_changed'
