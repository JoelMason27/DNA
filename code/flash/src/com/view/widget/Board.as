package com.view.widget 
{
	import com.controller.BoardController;
	import com.greensock.TweenLite;
	import com.hurlant.util.der.Integer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class Board extends MovieClip
	{
		public var m_tilesX:int;
		public var m_tilesY:int;
		public var m_boardBlocks:Vector.<Vector.<Block>>;
		
		public function Board() 
		{
			m_tilesX = 5;
			m_tilesY = 5;
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		public function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			m_boardBlocks = BoardController.instance.newBoard(m_tilesX, m_tilesY);
			displayBoard();
		}
		
		private function refillBoard():void
		{
			for (var _i:int = 0; _i < m_boardBlocks.length; _i++)
			{
				var _added:int = 0;
				while (m_boardBlocks[_i].length < m_tilesY)
				{
					_added++;
					var _b:Block = new Block();
					_b.x = 200 - (_i * 50)
					_b.y = -(_added * 50);
					m_boardBlocks[_i].push(_b);
					_b.m_blockClickedSignal.addListener(onBlockClicked);
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
					_b.x = 200 - (_i * 50);
					_b.y = 200 -(_j * 50);
					_b.m_blockClickedSignal.addListener(onBlockClicked);
					addChild(_b);
				}
			}
		}
		
		public function removeBlocks(p_vector:Vector.<Block>):void
		{
			trace("Removing", p_vector.length);
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
		
		public function onBlockClicked(p_block:Block):void
		{
			removeBlocks(BoardController.instance.getAllBlocksOfType(p_block.text, m_boardBlocks));
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
					var _destX = 200 - (_i * 50);
					var _destY = 200 - (_j * 50);
					TweenLite.to(_b, 1, { x : _destX, y : _destY } );
				}
			}
		}
	}

}