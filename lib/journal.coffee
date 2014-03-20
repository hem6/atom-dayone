exec = (require 'child_process').exec

module.exports =
  class Journal
    constructor: (body) ->
      @body = @escapeQuotes(body)

    escapeQuotes: (content) ->
      content.replace(/("|`|\$|\\)/g, (match, p1, offset, string)->
        return "\\" + p1
      )

    save: (callback) ->
      command = 'echo "' + @body + '" | ' +
                atom.config.get("dayone.dayonePath") + ' new'
      exec command, (err, stdout, stderr) =>
        callback(stderr)
