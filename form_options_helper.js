(function() {
  var FormOptionsHelper, TagHelper, helper,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  require('cream');

  TagHelper = require('tag-helper');

  FormOptionsHelper = (function() {

    function FormOptionsHelper() {
      this.extract_selected_and_disabled = __bind(this.extract_selected_and_disabled, this);
      this.is_option_value_selected = __bind(this.is_option_value_selected, this);
      this.option_text_and_value = __bind(this.option_text_and_value, this);
      this.option_html_attributes = __bind(this.option_html_attributes, this);
      this.options_for_select = __bind(this.options_for_select, this);
    }

    FormOptionsHelper.prototype.options_for_select = function(container, selected) {
      var disabled, _ref,
        _this = this;
      if (selected == null) selected = null;
      if (typeof container === 'string') return container;
      _ref = this.extract_selected_and_disabled(selected).map(function(r) {
        return Array.wrap(r).map(function(item) {
          if (item instanceof String) {
            return item;
          } else {
            return String(item);
          }
        });
      }), selected = _ref[0], disabled = _ref[1];
      if (Object.isPlainObject(container)) container = Object.toArray(container);
      return container.map(function(element) {
        var disabled_attribute, html_attributes, selected_attribute, text, value, _ref2;
        html_attributes = _this.option_html_attributes(element);
        _ref2 = _this.option_text_and_value(element).map(function(item) {
          if (item instanceof String) {
            return item;
          } else {
            return String(item);
          }
        }), text = _ref2[0], value = _ref2[1];
        if (_this.is_option_value_selected(value, selected)) {
          selected_attribute = ' selected="selected"';
        }
        if (disabled && _this.is_option_value_selected(value, disabled)) {
          disabled_attribute = ' disabled="disabled"';
        }
        return "<option value=\"" + (TagHelper.html_escape(value)) + "\"" + (selected_attribute || '') + (disabled_attribute || '') + (html_attributes || '') + ">" + (TagHelper.html_escape(text)) + "</option>";
      }).join("\n").html_safe();
    };

    FormOptionsHelper.prototype.option_html_attributes = function(element) {
      var html_attributes, k, v, _ref;
      if (!(element instanceof Array)) return "";
      html_attributes = [];
      _ref = element.select(function(e) {
        return Object.isPlainObject(e);
      }).reduce(Object.merge, {});
      for (k in _ref) {
        if (!__hasProp.call(_ref, k)) continue;
        v = _ref[k];
        html_attributes.push(" " + k + "=\"" + (TagHelper.html_escape(v.toString())) + "\"");
      }
      return html_attributes.join('');
    };

    FormOptionsHelper.prototype.option_text_and_value = function(option) {
      var _this = this;
      if (option instanceof Array) {
        option = option.reject(function(e) {
          return Object.isPlainObject(e);
        });
        return [option.first(), option.last()];
      } else if ((!(option instanceof String)) && (option.first instanceof Function) && (option.last instanceof Function)) {
        return [option.first(), option.last()];
      } else {
        return [option, option];
      }
    };

    FormOptionsHelper.prototype.is_option_value_selected = function(value, selected) {
      if (selected instanceof Array) {
        return __indexOf.call(selected, value) >= 0;
      } else if (Object.isPlainObject(selected)) {
        return selected[value] != null;
      } else {
        return value === selected;
      }
    };

    FormOptionsHelper.prototype.extract_selected_and_disabled = function(selected) {
      var options;
      if (selected instanceof Function) {
        return [selected, null];
      } else {
        selected = Array.wrap(selected);
        options = selected.extract_options();
        return [(options.selected != null ? options.selected : selected), options.disabled];
      }
    };

    return FormOptionsHelper;

  })();

  helper = new FormOptionsHelper();

  exports.options_for_select = helper.options_for_select;

}).call(this);
