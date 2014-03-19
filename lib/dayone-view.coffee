{View} = require 'atom'

module.exports =
class DayoneView extends View
  @content: ->
    @div class: 'dayone overlay from-top padded', =>
      @div class: 'inset-panel', =>
        @div class: 'panel-heading', =>
          @span "DayOne"
        @div class: "panel-body padded", =>
          @div class: "message", outlet: "messageView"

  initialize: (serializeState) ->

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  success: (message) ->
    @setMessage(message, "success")
    @display()

  error: (message) ->
    @setMessage(message, "error")
    @display()

  setMessage: (message, status) ->
    @messageView.empty()
    @messageView.append View.render ->
      @span class:"text-#{status}", message

  display: ->
    atom.workspaceView.append(this)
    setTimeout (=>
      @detach()
    ), 4000
