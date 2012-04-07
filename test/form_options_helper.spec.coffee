FormOptionsHelper = require '../form_options_helper.coffee'

describe "FormOptionsHelper", ->
  it 'options_for_select([["Dollar", "$"], ["Kroner", "DKK"]]) should be <option value="$">Dollar</option>\n<option value="DKK">Kroner</option>', ->
    expect(FormOptionsHelper.options_for_select([["Dollar", "$"], ["Kroner", "DKK"]])).toEqual '<option value="$">Dollar</option>\n<option value="DKK">Kroner</option>'

  it 'options_for_select([ "VISA", "MasterCard" ], "MasterCard") should be "<option value=\"VISA\">VISA</option>\n<option value=\"MasterCard\" selected=\"selected\">MasterCard</option>"', ->
    expect(FormOptionsHelper.options_for_select([ "VISA", "MasterCard" ], "MasterCard")).toEqual "<option value=\"VISA\">VISA</option>\n<option value=\"MasterCard\" selected=\"selected\">MasterCard</option>"
  it 'options_for_select({ "Basic" => "$20", "Plus" => "$40" }, "$40") should be <option value="$20">Basic</option>\n<option value="$40" selected="selected">Plus</option>', ->
    expect(FormOptionsHelper.options_for_select({ "Basic": "$20", "Plus": "$40" }, "$40")).toEqual '<option value="$20">Basic</option>\n<option value="$40" selected="selected">Plus</option>'
  it 'options_select can have multiple selected values', ->
    expect(FormOptionsHelper.options_for_select([ "VISA", "MasterCard", "Discover" ], ["VISA", "Discover"])).toEqual "<option value=\"VISA\" selected=\"selected\">VISA</option>\n<option value=\"MasterCard\">MasterCard</option>\n<option value=\"Discover\" selected=\"selected\">Discover</option>"

  it 'options_select can accept html options for an option', ->
    expect(FormOptionsHelper.options_for_select([ "Denmark", ["USA", {'class': 'bold'}], "Sweden" ], ["USA", "Sweden"])).toEqual "<option value=\"Denmark\">Denmark</option>\n<option value=\"USA\" selected=\"selected\" class=\"bold\">USA</option>\n<option value=\"Sweden\" selected=\"selected\">Sweden</option>"

  it 'options_select can accept an onclick value for an option', ->
    expect(FormOptionsHelper.options_for_select([["Dollar", "$", {'class': "bold"}], ["Kroner", "DKK", {'onclick': "alert('HI');"}]])).toEqual "<option value=\"$\" class=\"bold\">Dollar</option>\n<option value=\"DKK\" onclick=\"alert('HI');\">Kroner</option>"
  
  it "options_select can accept a disabled string", ->
    expect(FormOptionsHelper.options_for_select(["Free", "Basic", "Advanced", "Super Platinum"], disabled: "Super Platinum")).toEqual "<option value=\"Free\">Free</option>\n<option value=\"Basic\">Basic</option>\n<option value=\"Advanced\">Advanced</option>\n<option value=\"Super Platinum\" disabled=\"disabled\">Super Platinum</option>"

  it "options_select can accept a disabled array", ->
    expect(FormOptionsHelper.options_for_select(["Free", "Basic", "Advanced", "Super Platinum"], disabled: ["Advanced", "Super Platinum"])).toEqual "<option value=\"Free\">Free</option>\n<option value=\"Basic\">Basic</option>\n<option value=\"Advanced\" disabled=\"disabled\">Advanced</option>\n<option value=\"Super Platinum\" disabled=\"disabled\">Super Platinum</option>"

  it "options_select can accept a selected string and a disabled string", ->
    expect(FormOptionsHelper.options_for_select(["Free", "Basic", "Advanced", "Super Platinum"], selected: "Free", disabled: "Super Platinum")).toEqual "<option value=\"Free\" selected=\"selected\">Free</option>\n<option value=\"Basic\">Basic</option>\n<option value=\"Advanced\">Advanced</option>\n<option value=\"Super Platinum\" disabled=\"disabled\">Super Platinum</option>"
