
class Ideadb.Views.Ideas.CommentView extends Backbone.Marionette.ItemView
  template: JST["backbone/templates/ideas/comment"]

  className: "comment"

  events:
    'click .delete-comment': 'deleteComment'


  deleteComment: (e) ->
    e.preventDefault()
    if window.confirm("My God, it's the future. My parents, my co-workers, my comment. I'll never see any of them again.") == true
      @model.destroy()


