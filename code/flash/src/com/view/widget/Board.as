package com.view.widget 
{
	import cerebralfix.zill.flash.ZILMovieClip;
	import com.controller.BoardController;
	import com.greensock.TweenLite;
	import com.hurlant.util.der.Integer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class Board extends ZILMovieClip
	{
		static const TILES_X:int = 5;
		static const TILES_Y:int = 5;
		static const TILE_WIDTH:int = 50;
		static const BOARD_SIZE:int = TILES_X * TILE_WIDTH;
		public var m_boardBlocks:Vector.<Vector.<Block>>;
		
		public function Board() 
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			m_boardBlocks = BoardController.instance.newBoard(TILES_X, TILES_Y);
			displayBoard();
		}
		
		private function refillBoard():void
		{
			for (var _i:int = 0; _i < m_boardBlocks.length; _i++)
			{
				var _added:int = 0;
				while (m_boardBlocks[_i].length < TILES_Y)
				{
					_added++;
					var _b:Block = new Block();
					_b.x = (_i * TILE_WIDTH)
					_b.y = -(_added * TILE_WIDTH);
					m_boardBlocks[_i].push(_b);
					addChild(_b);
				}
			}
		}
		
		private function displayBoard():void
		{
			for (var _i:int = 0; _i < m_boardBlocks.length; _i++)
			{
				for (var _j:int = 0; _j < m_boardBlocks[_i].length; _j++)
				{
					var _b:Block = m_boardBlocks[_i][_j];
					_b.x = (_i * TILE_WIDTH);
					_b.y = ((TILES_Y - _j - 1) * TILE_WIDTH);
					addChild(_b);
				}
			}
		}
		
		public function removeBlocks(p_vector:Vector.<Block>):void
		{
			for each (var _b:Block in p_vector)
			{
				removeBlock(_b);
			}
		}
		
		public function removeBlock(p_block:Block):void
		{
			for each (var vec:Vector.<Block> in m_boardBlocks)
			{
				var _index:int = vec.indexOf(p_block)
				if (_index != -1)
				{
					vec.splice(_index, 1);
					removeChild(p_block);
					//TweenLite.to(p_block, 0.1, { width : 0, height : 0, onComplete : removeChild, onCompleteParams : [p_block] } );
				}
			}
		}
		
		public function onMouseClick(e:MouseEvent = null):void
		{
			removeBlocks(BoardController.instance.getAllBlocksOfType((e.target as Block).text, m_boardBlocks));
			refillBoard();
			dropRows();
		}
		
		private function dropRows():void
		{
			for (var _i:int = 0; _i < m_boardBlocks.length; _i++)
			{
				for (var _j:int = 0; _j < m_boardBlocks[_i].length; _j++)
				{
					var _b:Block = m_boardBlocks[_i][_j];
					var _destX =  (_i * TILE_WIDTH);
					var _destY =  ((TILES_Y - _j - 1) * TILE_WIDTH);
					TweenLite.to(_b, 1, { x : _destX, y : _destY } );
				}
			}
		}
	}

}