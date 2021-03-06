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
package ftk.net
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	import ftk.data.DataModel;
	import ftk.events.LoadEvent;

	/**
	 * This class is the super class for classes which are used to load file(s).
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class LoaderObject extends DataModel
	{
		/**
		 * 
		 * @default 
		 */
		protected var _loaded:Boolean = false;

		/**
		 * 
		 * @default 
		 */
		protected var _failed:Boolean = false;

		/**
		 * 
		 * @default 
		 */
		protected var _loadrate:Number = 0;

		/**
		 * 
		 * @return 
		 */
		public function get loaded():Boolean
		{
			return _loaded;
		}

		/**
		 * 
		 * @return 
		 */
		public function get failed():Boolean
		{
			return _failed;
		}

		/**
		 * 
		 * @return 
		 */
		public function get rate():Number
		{
			return _loadrate;
		}

		/**
		 * 
		 * @param target
		 */
		protected function setEvent(target:IEventDispatcher):void
		{
			target.addEventListener(Event.COMPLETE, loadedHandler);
			target.addEventListener(ProgressEvent.PROGRESS, loadingHandler);
			target.addEventListener(IOErrorEvent.IO_ERROR, loadFailedHandler);
		}

		/**
		 * 
		 * @param e
		 */
		protected function loadedHandler(e:Event):void
		{
			_loaded = true;
			_failed = false;
			_loadrate = 1;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			this.dispatchEvent(ee);
		}

		/**
		 * 
		 * @param e
		 */
		protected function loadingHandler(e:ProgressEvent):void
		{
			_loaded = false;
			_failed = false;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			ee.bytesLoaded = e.bytesLoaded;
			ee.bytesTotal = e.bytesTotal;
			ee.loadedRate = ee.bytesLoaded / ee.bytesTotal;
			_loadrate = ee.loadedRate;
			this.dispatchEvent(ee);
		}

		/**
		 * 
		 * @param e
		 */
		protected function loadFailedHandler(e:IOErrorEvent):void
		{
			_loaded = false;
			_failed = true;
			_loadrate = 0;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			this.dispatchEvent(ee);
		}
	}
}