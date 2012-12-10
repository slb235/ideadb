Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IdeaView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/ideas/idea"]

  events: 
    'click .idea-title': 'makeTitleEditable'
    'click .remove': 'removeIdea'
    'click .rm-tag': 'removeTag'
    'keydown .idea-title': 'keydownTitle'
    'blur .idea-title': 'finishedEditing'

  makeTitleEditable: (e) ->
    @$('.idea-title').attr 'contenteditable', 'true'
    window.Ideadb.Application.vent.trigger 'lock_updates', true

  keydownTitle: (e) ->
    if e.keyCode == 13
      @$('.idea-title').blur()

  finishedEditing: () ->
    @$('.idea-title').attr 'contenteditable', 'false'
    @model.attributes.title = @$('.idea-title').html()
    @model.save()
    window.Ideadb.Application.vent.trigger 'lock_updates', false

  removeIdea: () ->
    @model.destroy()

  removeTag: (e) ->
    e.stopPropagation()
    @model.attributes.tags = _.reject @model.attributes.tags, (tag) -> tag.id == $(e.target).data('tag-id')
    @model.save()
    @render()

