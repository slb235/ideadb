class Ideadb.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

  defaults:
    title: null

class Ideadb.Collections.CommentsCollection extends Backbone.Collection
  model: Ideadb.Models.Comment

  url: () -> "/projects/#{window.Ideadb.Config.project_id}/ideas/#{@idea_id}/comments"

  initialize: (models, options) ->
    if options.idea
      @idea_id = options.idea.get('id')
