Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IdeaView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/ideas/idea"]
  className: "idea"

  events: 
    'dblclick .idea-title.view': 'makeTitleEditable'
    'click .remove': 'showRemoveModal'
    'click .remove-idea': 'removeIdea'
    'click .rm-tag': 'removeTag'
    'click .show-tag-add': 'showTagAdd'
    'click .show-comments': 'showComments'
    'click .anchor': 'filterForIdea'
    'blur .idea-title.edit textarea': 'finishedEditing'
    'keypress .tag-input': 'onTagKeyPress'
    'click .user-filter': 'addUserFilter'

  initialize: () ->
    @known_tags = []
    window.Ideadb.Application.vent.on 'taglist_update', (taglist) =>
      @known_tags = taglist

    @comment_collection = new Ideadb.Collections.CommentsCollection [],
      idea: @model

    @comment_view = new Ideadb.Views.Ideas.CommentsView
      collection: @comment_collection

    @comments = false

  filterForIdea: (e) ->
    e.preventDefault()
    $('#search_query').val( $(e.target).attr('href') )
    $('#search_query').trigger('keyup')
    window.location.hash = "##{@model.id}"

  makeTitleEditable: (e) ->
    e.preventDefault()
    #@$('.idea-title').attr 'contenteditable', 'true'
    #@$('.idea-title').html @model.get('title')
    @$('.idea-title.view').hide()
    @$('.idea-title.edit').show()
    @$('.idea-title.edit textarea').focus()
    window.Ideadb.Application.vent.trigger 'lock_updates', true

  finishedEditing: () ->
    console.log 'finish editing'
    #@$('.idea-title').attr 'contenteditable', 'false'
    @model.attributes.title = @$('.idea-title.edit textarea').val()
    @model.save()
    @render()
    window.Ideadb.Application.vent.trigger 'lock_updates', false

  showTagAdd: (e) ->
    e.preventDefault()
    @$('.tag-add-line').show()
    @$('.tag-input').focus()
    @.$('.tag-input').typeahead
      source: (query) =>
        return window.router.addView.known_tags.filter (t) -> t.toLowerCase().indexOf(query.toLowerCase()) != -1

  showRemoveModal: (e) ->
    e.preventDefault()
    @$('.remove-modal').modal('show')

  removeIdea: (e) ->
    e.preventDefault()
    @model.destroy()

  removeTag: (e) ->
    e.preventDefault()
    @model.set 'tags', _.reject @model.get('tags'), (tag) -> tag.id == $(e.target).data('tag-id')
    @model.save()
    @render()

  onTagKeyPress: (e) ->
    if e.keyCode == 13
      val = @.$('.tag-input').val().trim()
      @.$('.tag-input').val ''
      if val.length
        unless _.find(@model.get('tags'), (t) -> t.name == val)
          @model.set 'tags', _.flatten [@model.get('tags'), {id: 0, name: val}]
          @model.save()
          @render()
      @$('.tag-add-line').hide()

  onRender: () ->
    if @comments
      @comment_collection.fetch()
      @$('.comments').html @comment_view.render().$el
      @$('.comments').show()
      @$('.icon-toggle').removeClass('icon-comment-alt').addClass('icon-comments-alt')


  showComments: (e) ->
    e.preventDefault()
    @comments = ! @comments
    @render()

  addUserFilter: (e) ->
    e.preventDefault()
    window.Ideadb.Application.vent.trigger 'add_filter',
      user: @model.get('user').name
