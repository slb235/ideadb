Ideadb.Views.Ideas ||= {}

class Ideadb.Views.Ideas.IndexView extends Backbone.Marionette.CompositeView
  template: JST["backbone/templates/ideas/index"]
  itemView: Ideadb.Views.Ideas.IdeaView
  itemViewContainer: "ul"
  
