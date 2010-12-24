/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.ui.glazes
{
	import flash.display.GradientType;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import org.finalbug.ui.Glaze;
	import org.finalbug.ui.style.FillStyle;
	
	/**
	 * display.Flat
	 * 
	 * @author Tang Bin
	 * @since old version
	 */	
	public class Flat extends Glaze
	{
		public function Flat(width:Number = 10, height:Number = 10, style:FillStyle = null)
		{
			super();
			this._fillStyle = style == null ? new FillStyle() : style;
			this.displayWidth = width;
			this.displayHeight = height;
			updateView();
		}
		
		public function refresh():void
		{
			this.updateView();
		}
	}
}