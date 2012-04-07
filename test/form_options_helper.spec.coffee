FormOptionsHelper = require '../form_options_helper.coffee'

describe "FormOptionsHelper", ->
  it 'options_for_select([["Dollar", "$"], ["Kroner", "DKK"]]) should be <option value="$">Dollar</option>\n<option value="DKK">Kroner</option>', ->
    expect(FormOptionsHelper.options_for_select([["Dollar", "$"], ["Kroner", "DKK"]])).toEqual '<option value="$">Dollar</option>\n<option value="DKK">Kroner</option>'

