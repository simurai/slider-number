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

    @subscriptions.add atom.commands.add 'atom-workspace',
      'slider-number:small-down': => @smalldown()

    @subscriptions.add atom.commands.add 'atom-workspace',
      'slider-number:small-up': => @smallup()

  deactivate: ->
    @subscriptions.dispose()

  change_number: (num) ->
      if editor = atom.workspace.getActiveTextEditor()
         selection = editor.getSelectedText()
         if !isNaN(selection)
            number = parseFloat( selection )
            number = number + num

            # remove decimal if it's: `.0`
            if number - number.toFixed(0) == 0
              number = number.toFixed(0)
            else
              number = number.toFixed(1)

            editor.insertText("#{number}", {select:true})

  up: ->
      @change_number(1)
  down: ->
      @change_number(-1)
  bigup: ->
      @change_number(10)
  bigdown: ->
      @change_number(-10)
  smallup: ->
      @change_number(0.1)
  smalldown: ->
      @change_number(-0.1)
