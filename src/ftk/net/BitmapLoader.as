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
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	import ftk.data.DataModel;
	import ftk.events.LoadEvent;

	/**
	 * This class is used to load a image file.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class BitmapLoader extends DataModel
	{
		/**
		 * Create a new BitmapLoader.
		 * 
		 * @param URL Image file URL.
		 */
		public function BitmapLoader(URL:String, loadAtStart:Boolean = true)
		{
			_url = URL;
			if (loadAtStart)
			{
				doLoad();
			}
		}

		private var loader:Loader;

		private var _url:String;

		private var _loaded:Boolean = false;

		private var _failed:Boolean = false;

		private var _percent:Number = 0;

		/**
		 * File is loaded or not.
		 */
		public function get loaded():Boolean
		{
			return _loaded;
		}

		/**
		 * Load file failed or not.
		 */
		public function get failed():Boolean
		{
			return _failed;
		}

		/**
		 * Loaded percent.
		 */
		public function get percent():Number
		{
			return _percent;
		}

		/**
		 * Loaded bitmap.
		 */
		public function get bitmap():Bitmap
		{
			if (_loaded && (loader.content as Bitmap) != null)
			{
				return new Bitmap((loader.content as Bitmap).bitmapData.clone());
			}
			return null;
		}

		/**
		 * Change current image file URL and reload.
		 * 
		 * @param URL
		 * 
		 * @throw errors.Errors Throw URLisEmpty error when URL parameter is "".
		 */
		public function changeBitmap(URL:String):void
		{
			_url = URL;
			doLoad();
		}

		/**
		 * 
		 */
		public function load():void
		{
			doLoad();
		}

		private function doLoad():void
		{
			if (_url != null)
			{
				_loaded = _failed = false;
				_percent = 0;
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadSuccessHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadFailedHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadingHandler);
				loader.load(new URLRequest(_url));
			}
			else
			{
				_loaded = _failed = false;
				_percent = 0;
				loader = null;
			}
		}

		private function loadSuccessHandler(e:Event):void
		{
			_loaded = true;
			_failed = false;
			_percent = 1;
			var newE:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			newE.data = this.bitmap;
			this.dispatchEvent(newE);
		}

		private function loadFailedHandler(e:IOErrorEvent):void
		{
			_loaded = false;
			_failed = true;
			_percent = 0;
			var newE:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			this.dispatchEvent(newE);
		}

		private function loadingHandler(e:ProgressEvent):void
		{
			_loaded = false;
			_failed = false;
			var newE:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			newE.bytesLoaded = e.bytesLoaded;
			newE.bytesTotal = e.bytesTotal;
			newE.loadedRate = newE.bytesLoaded / newE.bytesTotal;
			_percent = newE.loadedRate;
			this.dispatchEvent(newE);
		}
	}
}