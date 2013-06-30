package com.view.screen 
{
	import cerebralfix.zill.flash.ZILScreen;
	import com.view.widget.Board;
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class ScreenGame extends ZILScreen
	{
		private var m_board:Board;
		
		public function ScreenGame() 
		{
			m_board = new Board();
			m_board.x = 0;
			m_board.y = 0;
			addChild(m_board);
		}
		
	}

}