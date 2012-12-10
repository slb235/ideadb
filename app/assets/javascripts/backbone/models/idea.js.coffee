class Ideadb.Models.Idea extends Backbone.Model
  paramRoot: 'idea'

  defaults:
    title: null
    project_id: 1

class Ideadb.Collections.IdeasCollection extends Backbone.Collection
  model: Ideadb.Models.Idea
  url: '/projects/1/ideas'

  initialize: () ->
    @.bind 'change reset add remove', @generate_tag_list

  generate_tag_list: () ->
    window.Ideadb.Application.vent.trigger 'taglist_update', _.flatten @.map (idea) ->
      _.map idea.attributes.tags, (tag) ->
        tag.name

