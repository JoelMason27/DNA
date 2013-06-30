package com.view.widget 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class Base_A extends Block 
	{
		
		public function Base_A() 
		{
			
		}
		
		override protected function initialize(e:Event = null):void 
		{
			super.initialize(e);
			text = "A";
		}
		
	}

}