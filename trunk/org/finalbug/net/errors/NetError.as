package org.finalbug.net.errors
{
	public class NetError extends Error
	{
		public function NetError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}