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
    flat_tags = _.flatten @.map (idea) ->
      _.map idea.attributes.tags, (tag) ->
        tag.name

    uniq_tags = _.unique flat_tags
    weighted_tags = {}

    _.each flat_tags, (tag) ->
      if weighted_tags[tag]
        weighted_tags[tag]++
      else
        weighted_tags[tag] = 1

    window.Ideadb.Application.vent.trigger 'taglist_update', uniq_tags, weighted_tags

  update_ideas: () =>
    @fetch() unless @update_lock

  lock_updates: (lock) =>
    @update_lock = lock


