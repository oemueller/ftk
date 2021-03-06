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
package ftk.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import ftk.errors.DataError;
	import ftk.style.LayoutStyle;

	/**
	 * LayoutManager. Singleton mode.
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */
	public class LayoutManager
	{
		/**
		 * 
		 * @throws DataError
		 */
		public function LayoutManager()
		{
			if (!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
		}

		// SINGLETON
		private static var instanceable:Boolean = false;

		private static var lm:LayoutManager;

		/**
		 * 
		 * @return 
		 */
		public static function get instance():LayoutManager
		{
			if (lm == null)
			{
				instanceable = true;
				lm = new LayoutManager();
				instanceable = false;
			}
			return lm;
		}

		private var list:Dictionary = new Dictionary();

		/**
		 * 
		 * @param target
		 * @param data
		 */
		public function addLayout(target:DisplayObject, data:LayoutStyle):void
		{
			list[target] = data;
			data.owner = target;
		}

		/**
		 * 
		 * @param target
		 * @throws DataError
		 */
		public function removeLayout(target:DisplayObject):void
		{
			if (list[target] == null)
			{
				throw new DataError(DataError.DATA_NULL);
			}
			list[target] = null;
			delete list[target];
		}

		/**
		 * 
		 * @param root
		 */
		public function update(root:DisplayObject):void
		{
			if (root != null)
			{
				if (list[root] != null)
				{
					updateLayout(root);
				}
				if (root is DisplayObjectContainer)
				{
					var rootObj:DisplayObjectContainer = root as DisplayObjectContainer;
					for (var i:uint = rootObj.numChildren ; --i >= 0 ; )
					{
						var obj:DisplayObject = rootObj.getChildAt(i) as DisplayObject;
						update(obj);
					}
				}
			}
		}

		private function updateLayout(target:DisplayObject):void
		{
			var data:LayoutStyle = list[target] as LayoutStyle;
			target.width = data.width;
			target.height = data.height;
			target.x = data.x;
			target.y = data.y;
		}
	}
}