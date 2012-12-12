
class Ideadb.Views.Ideas.CommentsView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/ideas/comments"]
  itemView: Ideadb.Views.Ideas.CommentView
  itemViewContainer: "#comments-container"

  events:
    'keypress .new-comment': 'newCommentKeypress'


  newCommentKeypress: (e) ->
    if e.keyCode == 13
      e.preventDefault()
      val = @$('.new-comment').val().trim()
      if val.length
        @collection.create
          user: window.Ideadb.Config.current_user
          content: val
         @$('.new-comment').val('')
        
