
class Ideadb.Views.Ideas.CommentView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/ideas/comment"]

  className: "comment"

  events:
    'click .delete-comment': 'deleteComment'


  deleteComment: (e) ->
    e.preventDefault()
    @model.destroy()



