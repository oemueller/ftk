/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.ui.control
{
	import org.finalbug.data.Status;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.ui.style.stylefactory.ButtonStyleFactory;
	
	/******************************************
	 * org.finalbug.ui.control.Button
	 * 
	 * @author Tang Bin
	 * @since old version
	 *****************************************/
	public class Button extends UIObject
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private var _labelStr:String = "Button";
		
		private var _label:Label;
		private var bg:Flat;
		private var icon:Image;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get label():String
		{
			return _labelStr;
		}
		public function set label(value:String):void
		{
			if(_labelStr != value)
			{
				_labelStr = value;
				this.updateView();
			}
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function Button(text:String = "Button")
		{
			super();
			this.mouseChildren = false;
			this._labelStr = text;
			createChildren();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function updateView():void
		{
			super.updateView();
			if(currentStyle != null)
			{
				bg.fillStyle = currentStyle.fillStyle;
				_label.textFormat = currentStyle.textStyle.format;
				bg.resize(displayWidth, displayHeight);
				_label.toCenter();
			}
		}
		
		//***************************************
		// PUBLIC
		//***************************************
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function createChildren():void
		{
			// create elements
			bg = new Flat();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			this.registerStatus(Status.NORMAL, ButtonStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.MOUSE_OVER, ButtonStyleFactory.createOverStyle());
			this.registerStatus(Status.MOUSE_DOWN, ButtonStyleFactory.createDownStyle());
			this.registerStatus(Status.DISABLE, ButtonStyleFactory.createDisableStyle());
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}