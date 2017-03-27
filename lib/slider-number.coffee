{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'slider-number:up': => @up()

    @subscriptions.add atom.commands.add 'atom-workspace',
      'slider-number:down': => @down()

    @subscriptions.add atom.commands.add 'atom-workspace',
      'slider-number:big-down': => @bigdown()

    @subscriptions.add atom.commands.add 'atom-workspace',
      'slider-number:big-up': => @bigup()

  deactivate: ->
    @subscriptions.dispose()

  change_number: (num) ->
      if editor = atom.workspace.getActiveTextEditor()
         selection = editor.getSelectedText()
         if !isNaN(selection)
            number = parseInt( selection, 10 )
            number = number + num
            editor.insertText("#{number}", {select:true})

  up: ->
      @change_number(1)
  down: ->
      @change_number(-1)
  bigup: ->
      @change_number(10)
  bigdown: ->
      @change_number(-10)
