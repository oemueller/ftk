/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import mx.controls.Text;
	
	import org.finalbug.data.Status;
	
	/**
	 * TextSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class TextSkinData extends UISkinDataBase
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		[Embed(source="/resources/skins/text_normal.png")]
		private var textNormalCls:Class;
		[Embed(source="/resources/skins/text_force.png")]
		private var textForceCls:Class;
		[Embed(source="/resources/skins/text_disable.png")]
		private var textDisableCls:Class;
		
		private var box:SkinElement;
		private var text:TextField;
		
		private var boxSkins:Dictionary;
		private var textFormats:Dictionary;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function TextSkinData()
		{
			super();
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new textNormalCls(), true);
			boxSkins[Status.ACTIVE] = new SkinElementData(Status.ACTIVE, SkinElementData.BITMAP_TYPE, new textForceCls());
			boxSkins[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new textDisableCls());
			//
			textFormats = new Dictionary();
			textFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		override public function setSkin(...args):void
		{
			box = args[0] as SkinElement;
			if(box != null)
			{
				this.setStatusSkinByList(box, boxSkins);
			}
			text = args[1] as TextField;
			if(text != null)
			{
				text.setTextFormat(textFormats[Status.NORMAL]);
				text.defaultTextFormat = textFormats[Status.NORMAL];
			}
		}
		
		override public function setStatus(status:String):void
		{
			if(box != null)
			{
				box.status = status;
			}
			if(text != null && textFormats[status] != null)
			{
				text.setTextFormat(textFormats[status]);
				text.defaultTextFormat = textFormats[status];
			}
		}
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}