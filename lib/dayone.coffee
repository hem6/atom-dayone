Journal = require './journal'
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  config:
    dayonePath:
      type: "string"
      default: "/usr/local/bin/dayone"

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', "dayone:create": => @create()

  deactivate: ->
    @subscriptions.dispose()

  create: ->
    editor = atom.workspace.getActiveTextEditor()
    body = editor.getText()

    journal = new Journal(body)
    journal.save (error) =>
      if error
        atom.notifications.addError("DayOne: Error", {detail: error})
      else
        atom.notifications.addSuccess("DayOne: Created")
