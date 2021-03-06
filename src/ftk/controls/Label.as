// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.controls
{
	import ftk.errors.DataError;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * controls.Label
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Label extends UIControl
	{
		/**
		 * 
		 * @param text
		 * @param textFormat
		 */
		public function Label(text:String = "", textFormat:TextFormat = null)
		{
			this.autoMouseEvent = true;
			str = text;
			if (textFormat == null)
			{
				ft = new TextFormat("Verdana", 12, 0x333333);
			}
			else
			{
				ft = textFormat;
			}
			createLabel();
		}

		override public function set width(value:Number):void
		{
			textWidth = value > 0 ? value : 0;
			createLabel();
		}

		override public function get width():Number
		{
			return img.width;
		}

		override public function set height(value:Number):void
		{
		}

		override public function get height():Number
		{
			return img.height;
		}

		private var str:String;

		private var ft:TextFormat;

		private var img:Bitmap;

		private var textWidth:Number = 0;

		/**
		 * 
		 * @return 
		 */
		public function get text():String
		{
			return str;
		}

		/**
		 * 
		 * @param v
		 */
		public function set text(v:String):void
		{
			str = v;
			createLabel();
		}

		/**
		 * 
		 * @return 
		 */
		public function get textColor():uint
		{
			return uint(ft.color);
		}

		/**
		 * 
		 * @param v
		 */
		public function set textColor(v:uint):void
		{
			ft.color = v;
			createLabel();
		}

		/**
		 * 
		 * @return 
		 */
		public function get textFormat():TextFormat
		{
			return ft;
		}

		/**
		 * 
		 * @param value
		 */
		public function set textFormat(value:TextFormat):void
		{
			ft = value;
			createLabel();
		}

		private function createLabel():void
		{
			this.tooltip = "";
			// create textField.
			var t:TextField = new TextField();
			t.multiline = true;
			t.setTextFormat(ft);
			t.defaultTextFormat = ft;
			// account display text string.
			if (this.textWidth > 0)
			{
				t.text = "...";
				var addedWidth:Number = t.textWidth;
				//
				t.text = str.charAt(0);
				var index:uint = 1;
				while (t.textWidth + addedWidth < this.textWidth && index < str.length)
				{
					t.appendText(str.charAt(index++));
				}
				if (index < str.length)
				{
					t.appendText("...");
					this.tooltip = str;
				}
			}
			else
			{
				t.text = str;
			}
			t.width = t.textWidth + 4;
			t.height = t.textHeight + 4;
			//
			// most of time Label is used to display text not very large (width and height).
			// because in Label text will be converted to bitmap to be displayed.
			try
			{
				var bd:BitmapData = new BitmapData(t.width, t.height, true, 0x00000000);
				bd.draw(t);
			}
			catch(e:Error)
			{
				throw new DataError(DataError.LABEL_TEXT_TOO_LARGE);
			}
			//
			if (img != null && this.contains(img))
			{
				this.removeChild(img);
			}
			img = new Bitmap(bd);
			this.addChild(img);
			//
			if (this.textWidth > 0)
			{
				img.x = (this.textWidth - img.width) / 2;
			}
			else
			{
				img.x = 0;
			}
		}
	}
}