/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.core.motion
{
	/**
	 * org.finalbug.fal.motion.MoveMotion
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	public class MoveMotion extends Motion
	{
		/**
		 * x coordinate that target object will move start.
		 * if not set, current target object's x coordinate will be taken as this value.
		 */		
		public var xFrom:Number;
		
		/**
		 * y coordinate that target object will move start.
		 * if not set, target object's current x coordinate will be taken as this value.  
		 */		
		public var yFrom:Number;
		
		/**
		 * x coordinate value that object will move to.
		 */		
		public var xTo:Number;
		/**
		 * y coordinate value that object will move to.
		 */		
		public var yTo:Number;
		
		public function MoveMotion(target:Object = null)
		{
			super(target);
		}
		
		/**
		 * account target object's position which will be used during moting effect.
		 * 
		 * @param target
		 */		
		override protected function count(target:Object):void
		{
			if(times >= 0)
			{
				/* account x values */
				var x0:Number = isNaN(xFrom) ? target["x"] : xFrom; // x from
				var x1:Number = isNaN(xTo) ? target["x"] : xTo; // x to
				/* account y values */
				var y0:Number = isNaN(yFrom) ? target["y"] : yFrom;
				var y1:Number = isNaN(yTo) ? target["y"] : yTo;
				//
				var startValues:Array = [x0, y0];
				var endValues:Array = [x1, y1];
				var steps:Array = counter.count(startValues, endValues, this.during);
				var xSteps:Array = steps[0];
				var ySteps:Array = steps[1];
				// register moting to runner.
				registeredMotions.push(MotionRunner.instance.register(target, "x", xSteps, this.times, this));
				registeredMotions.push(MotionRunner.instance.register(target, "y", ySteps, this.times));
			}
		}
	}
}