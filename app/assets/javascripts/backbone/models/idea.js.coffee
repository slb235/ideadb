class Ideadb.Models.Idea extends Backbone.Model
  paramRoot: 'idea'

  defaults:
    title: null
    project_id: 1

class Ideadb.Collections.IdeasCollection extends Backbone.Collection
  model: Ideadb.Models.Idea
  url: '/projects/1/ideas'
