Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.AddView extends Backbone.View
  template: JST["backbone/templates/ideas/add"]

  tagName: "div"
  className: "iwell"

  events:
    'keydown #new_idea_tags': 'updatePopover'
    'keypress #new_idea_tags': 'onTagKeyPress'
    'click .rm-tag': 'onTagRemove'
    'focus #new_idea_title': 'showIdeaPopover'
    'blur #new_idea_title': 'hideIdeaPopover'
    'focus #new_idea_tags': 'showTagsPopover'
    'blur #new_idea_tags': 'hideTagsPopover'

  initialize: () ->
    @known_tags = []
    @add_tags = []

    window.Ideadb.Application.vent.on 'taglist_update', (taglist) =>
      @known_tags = taglist

  showIdeaPopover: () ->
    @$('#new_idea_title').popover
      title: 'Describe your idea'
      content: '[Press TAB]'
    #@.$('#new_idea_title').popover 'show'
    autosize @$('#new_idea_title')


  hideIdeaPopover: () ->
    @$('#new_idea_title').popover 'hide'

  showTagsPopover: () ->
    @$('#new_idea_tags').popover
      title: 'Add tags'
      content: 'Add Tags or [Press Enter]'
    @$('#new_idea_tags').popover 'show'


  hideTagsPopover: () ->
    @$('#new_idea_tags').popover 'hide'

  render: () ->
    idea_title = ''
    idea_title = @.$('#new_idea_title').val() if @.$('#new_idea_title')

    @$el.html @template(add_tags: @add_tags)
    @$('#new_idea_title').val idea_title

    @$('#new_idea_tags').typeahead
      source: (query) =>
        return @known_tags.filter (t) -> t.toLowerCase().indexOf(query.toLowerCase()) != -1
    
  onTagKeyPress: (e) ->
    val = @$('#new_idea_tags').val().trim()
    if e.keyCode == 13
      if val.length
        unless _.contains @add_tags, val
          @add_tags.push val
          @render()
          @.$('#new_idea_tags').focus()
      else
        @onAddIdea()

  updatePopover: () ->
    val = @$('#new_idea_tags').val().trim()
    if @$('#new_idea_tags').data('popover').options.content != '[Press Enter]'
      @$('#new_idea_tags').data('popover').options.content = '[Press Enter]'
      @$('#new_idea_tags').popover 'show'

  onTagRemove: (e) ->
    e.preventDefault()
    @add_tags = _.reject @add_tags, (tag) -> tag == $(e.target).data('tag')
    @render()

  onAddIdea: (e) ->
    tags = _.map @add_tags, (t, i) ->
      id: i
      name: t
    @collection.create
      title: @.$('#new_idea_title').val()
      tags: tags
      user: window.Ideadb.Config.current_user
    @$('#new_idea_title').val('')
    @add_tags = []
    @render()


