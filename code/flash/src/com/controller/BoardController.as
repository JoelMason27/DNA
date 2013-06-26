package com.controller 
{
	import com.view.widget.Block;
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class BoardController 
	{
		private static var s_instance:BoardController;
		
		public function BoardController()
		{
			s_instance = this;
		}
		
		public static function get instance():BoardController
		{
			return s_instance || new BoardController();
		}
		
		public function newBoard(p_tilesX:int, p_tilesY:int):Vector.<Vector.<Block>>
		{
			var _boardBlocks:Vector.<Vector.<Block>> = new Vector.<Vector.<Block>>;
			for (var _i:int = 0; _i < p_tilesX; _i++)
			{
				_boardBlocks.push(new Vector.<Block>);
				for (var _j:int = 0; _j < p_tilesY; _j++)
				{
					var _block:Block = new Block();
					_boardBlocks[_i].push(_block);
				}
			}
			return _boardBlocks;
		}
		
		public function getAllBlocksOfType(p_type:String, p_board:Vector.<Vector.<Block>>):Vector.<Block>
		{
			var _returnVec:Vector.<Block> = new Vector.<Block>;
			for each (var _vec:Vector.<Block> in p_board)
			{
				for each (var _b:Block in _vec)
				{
					if (_b.text == p_type)
					{
						_returnVec.push(_b);
					}
				}
			}
			return _returnVec;
		}
		
	}

}