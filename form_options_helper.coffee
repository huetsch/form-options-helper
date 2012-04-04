# Copyright (C) 2012 Mark Huetsch
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

TagHelper = require 'tag-helper'

class FormOptionsHelper
  options_for_select: (container, selected = null) ->
    return container if typeof(container) is 'string'

    [selected, disabled] = @extract_selected_and_disabled(selected).map (r) ->
       Array.wrap(r).map (item) ->
         if item instanceof String
           item
         else
           String(item)

    container.map((element) ->
      html_attributes = @option_html_attributes(element)
      [text, value] = @option_text_and_value(element).map (item) ->
        if item instanceof String
          item
        else
          String(item)
      selected_attribute = ' selected="selected"' if @is_option_value_selected(value, selected)
      disabled_attribute = ' disabled="disabled"' if disabled and @is_option_value_selected(value, disabled)
      "<option value=\"#{TagHelper.html_escape(value)}\"#{selected_attribute}#{disabled_attribute}#{html_attributes}>#{TagHelper.html_escape(text)}</option>"
    ).join("\n").html_safe()

  option_html_attributes: (element) ->
    return "" unless element instanceof Array
    html_attributes = []
    for own k, v of element.select((e) -> Object.isPlainObject(e)).reduce(Object.merge, {})
      html_attributes.push " #{k}=\"#{TagHelper.html_escape(v.toString())}\""
    html_attributes.join('')

  option_text_and_value: (option) ->
    # Options are [text, value] pairs or strings used for both.
    if option instanceof Array
      option = option.reject (e) -> Object.isPlainObject(e)
      [option.first(), option.last()]
    else if (option not instanceof String) and (option.first instanceof Function) and (option.last instanceof Function)
      [option.first(), option.last()]
    else
      [option, option]

  is_option_value_selected: (value, selected) ->
    # from the Ruby:
    # if selected.respond_to?(:include?) && !selected.is_a?(String)
    if selected instanceof Array
      value in selected
    else if Object.isPlainObject(selected)
      selected[value]?
    else
      value is selected

  extract_selected_and_disabled: (selected) ->
    if selected instanceof Function
      [ selected, null ]
    else
      selected = Array.wrap(selected)
      options = selected.extract_options()
      [ (if options.selected? then options.selected else selected), options.disabled ]
