class Ideadb.Views.Ideas.SortingView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/ideas/sorting"]

  events:
    'click .sort': 'sort'
    'click .sortdesc': 'sortdesc'
    'change select': 'sortselect'

  ui:
    'icon_sort': '.icon-chevron-down'
    'icon_sort_desc': '.icon-chevron-up'
    'sorting': 'select'

  initialize: () ->
    @reverse = true;

  do_sort: (collection) =>
    collection = _.clone collection

    if @ui.sorting.val
      switch @ui.sorting.val()
        when 'date' then collection = _.sortBy collection, 'created_at'
        when 'author' then collection = _.sortBy collection, (item) -> item.get('user').name
        when 'shuffle' then collection = _.shuffle collection

    if @reverse
      return collection.reverse()
    else
      return collection


  sort: (e) =>
    e.preventDefault()
    @ui.icon_sort.addClass 'active'
    @ui.icon_sort_desc.removeClass 'active'
    @reverse = true
    Ideadb.Application.vent.trigger 'sorting_changed'


  sortdesc: (e) =>
    e.preventDefault()
    @ui.icon_sort_desc.addClass 'active'
    @ui.icon_sort.removeClass 'active'
    @reverse = false
    Ideadb.Application.vent.trigger 'sorting_changed'

  sortselect: (e) =>
    Ideadb.Application.vent.trigger 'sorting_changed'    
