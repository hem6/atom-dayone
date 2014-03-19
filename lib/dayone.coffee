DayoneView = require './dayone-view'
Journal = require './journal'

module.exports =
  dayoneView: null

  configDefaults:
    dayonePath: "/usr/local/bin/dayone"

  activate: (state) ->
    @dayoneView = new DayoneView(state.dayoneViewState)
    atom.workspaceView.command "dayone:create", => @create()

  deactivate: ->
    @dayoneView.destroy()

  serialize: ->
    dayoneViewState: @dayoneView.serialize()

  create: ->
    editor = atom.workspace.getActiveEditor()
    body = editor.getText()

    journal = new Journal(body)
    journal.save (error) =>
      if error
        @dayoneView.error(error)
      else
        @dayoneView.success("Successfully created.")
