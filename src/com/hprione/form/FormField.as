package com.hprione.form
{
	import com.hprione.form.validation.GenericFormFieldValidator;
	import com.hprione.string.Validate;
	
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FormField
	{
		public var placeholder:String;
		public var defaultTextFormat:TextFormat;
		public var parameter:String;
		public var validator:GenericFormFieldValidator;
		
		private var _field:TextField;
		
		public function FormField(field:TextField, defaultTextFormat:TextFormat, parameter:String)
		{
			this.defaultTextFormat = defaultTextFormat;
			this.parameter = parameter;
			this.field = field;
		}
		
		public function set field(value:TextField):void
		{
			unload();
			
			_field = value;
			if (_field) {
				_field.addEventListener(FocusEvent.FOCUS_IN, onFieldFocusInEventHandler);
				_field.addEventListener(FocusEvent.FOCUS_OUT, onFieldFocusOutEventHandler);
				_field.defaultTextFormat = defaultTextFormat;
				
				placeholder = _field.text;
			}
		}
		
		public function get value():String
		{
			return _field.text != placeholder ? _field.text : "";
		}
		
		public function unload():void
		{
			if (_field) {
				_field.removeEventListener(FocusEvent.FOCUS_IN, onFieldFocusInEventHandler);
				_field.removeEventListener(FocusEvent.FOCUS_OUT, onFieldFocusOutEventHandler);
				_field = null;
			}
		}
		
		public function validate():Boolean
		{
			return validator.validate(value);
		}
		
		private function onFieldFocusOutEventHandler(event:FocusEvent):void
		{
			if (Validate.isEmpty(_field.text)) {
				_field.text = placeholder;
			}
		}
		
		private function onFieldFocusInEventHandler(event:FocusEvent):void
		{
			if (_field.text == placeholder) {
				_field.text = "";
			}
		}
	}
}