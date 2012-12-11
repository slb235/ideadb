Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IdeaView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/ideas/idea"]

  events: 
    'click .idea-title': 'makeTitleEditable'
    'click .remove': 'showRemoveModal'
    'click .remove-idea': 'removeIdea'
    'click .rm-tag': 'removeTag'
    'click .show-tag-add': 'showTagAdd'
    'blur .idea-title': 'finishedEditing'

  makeTitleEditable: (e) ->
    @$('.idea-title').attr 'contenteditable', 'true'
    @$('.idea-title').html @model.get('title')
    window.Ideadb.Application.vent.trigger 'lock_updates', true


  finishedEditing: () ->
    @$('.idea-title').attr 'contenteditable', 'false'
    @model.attributes.title = @$('.idea-title').html()
    @model.save()
    @render()
    window.Ideadb.Application.vent.trigger 'lock_updates', false

  showTagAdd: () ->
    console.log 'mhh'
    @$('.tag-add-line').show()
    @$('.tag-input').focus()

  showRemoveModal: () ->
    @$('.remove-modal').modal('show')

  removeIdea: () ->
    @model.destroy()

  removeTag: (e) ->
    e.stopPropagation()
    @model.attributes.tags = _.reject @model.attributes.tags, (tag) -> tag.id == $(e.target).data('tag-id')
    @model.save()
    @render()

