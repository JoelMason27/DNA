package com.view.widget 
{
	import cerebralfix.felix.signal.FLXSignal;
	import cerebralfix.zill.flash.ZILMovieClip;
	import com.util.Utility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class Block extends ZILMovieClip
	{
		private var m_text:TextField;
		public var m_blockClickedSignal:FLXSignal = new FLXSignal();
		
		public function Block() 
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			m_text = new TextField();
			m_text.width = 50;
			m_text.height = 50;
			m_text.selectable = false;
			m_text.mouseEnabled = false;
			this.addChild(m_text);
			text = Utility.getBasePairChar();
		}
		
		private function onMouseClick(e:Event = null):void
		{
			m_blockClickedSignal.dispatch(this);
		}
		
		public function set text(p_text:String):void
		{
			m_text.text = p_text;
		}
		
		public function get text():String 
		{
			return m_text.text;	
		}
	}
}