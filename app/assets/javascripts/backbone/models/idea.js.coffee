class Ideadb.Models.Idea extends Backbone.Model
  paramRoot: 'idea'

  defaults:
    title: null

class Ideadb.Collections.IdeasCollection extends Backbone.Collection
  model: Ideadb.Models.Idea
  url: () -> "/projects/#{window.Ideadb.Config.project_id}/ideas"

  initialize: () ->
    @.bind 'change reset add remove', @generate_tag_list
    @update_lock = false

    window.Ideadb.Application.vent.on 'update_ideas', @update_ideas
    window.Ideadb.Application.vent.on 'lock_updates', @lock_updates

  generate_tag_list: () ->
    window.Ideadb.Application.vent.trigger 'taglist_update', _.unique  _.flatten @.map (idea) ->
      _.map idea.attributes.tags, (tag) ->
        tag.name

  update_ideas: () =>
    @fetch() unless @update_lock

  lock_updates: (lock) =>
    @update_lock = lock


