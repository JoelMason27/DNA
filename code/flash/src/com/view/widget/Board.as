package com.view.widget 
{
	import cerebralfix.felix.signal.FLXSignal;
	import cerebralfix.felix.type.array.FLXTriggeredArray;
	import cerebralfix.zill.flash.ZILMovieClip;
	import com.controller.BoardController;
	import com.greensock.TweenLite;
	import com.hurlant.util.der.Integer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Proxy;
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
		public var m_currentTilesSelected:FLXTriggeredArray = new FLXTriggeredArray();
		private var m_onMovedVectorChange:FLXSignal = new FLXSignal();
		
		private var m_lineOverlay:MovieClip = new MovieClip();
		
		public function Board() 
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			m_currentTilesSelected.changedSignal.addListener(onMovesChanged);
			m_boardBlocks = BoardController.instance.newBoard(TILES_X, TILES_Y);
			displayBoard();
			addChild(m_lineOverlay);
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
		
		public function removeBlocks(p_array:Array):void
		{
			for each (var _b:Block in p_array)
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
				}
			}
		}
		
		public function onMouseDown(e:MouseEvent = null):void
		{
			if (e.target is Block)
			{
				m_currentTilesSelected.push(e.target as Block);
			}
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function onMouseMove(e:MouseEvent = null):void
		{
			var _b:Block = e.target as Block;
			if (_b)
			{
				if (m_currentTilesSelected.value.length == 0)
				{
					m_currentTilesSelected.push(_b);
				}
				else
				{
					var _prevBlock:Block = m_currentTilesSelected.value[m_currentTilesSelected.value.length - 1];
					var _index = m_currentTilesSelected.value.indexOf(_b);
					//if it's not in the current list, matches the block type and is adjacent to the previous block
					if (_index == -1 && _prevBlock.text == _b.text && checkAdjacent(_b, _prevBlock))
					{
						//Add it
						m_currentTilesSelected.push(_b);
					}
					//otherwise, if it IS in the vector
					else if (_index != -1)
					{
						//and it's 1 away from the end (i.e. length -2)
						if (_index == m_currentTilesSelected.value.length - 2)
						{
							//we must've moved BACK to it, so pop the one after it
							var _removed:Block = m_currentTilesSelected.pop();
						}
					}
				}
			}
		}
		
		public function onMovesChanged(_b:Block = null):void
		{
			updateLineOverlay();
		}
		
		public function updateLineOverlay():void
		{
			m_lineOverlay.removeChildren();
			if (m_currentTilesSelected.value.length > 0)
			{
				var _line:Shape = new Shape();
				_line.graphics.moveTo(m_currentTilesSelected.value[0].x + (TILE_WIDTH / 2), m_currentTilesSelected.value[0].y + (TILE_WIDTH / 2));
				_line.graphics.lineStyle(2, 0xFF0000);
				
				var drawLineTo:Function = function(item:Block, index:int, array:Array):void {
					this.graphics.lineTo(item.x + (TILE_WIDTH / 2), item.y + (TILE_WIDTH / 2));
				};
				
				m_currentTilesSelected.value.forEach(drawLineTo, _line);
				
				_line.graphics.beginFill(0xFF0000);
				_line.graphics.drawCircle(m_currentTilesSelected.value[m_currentTilesSelected.value.length - 1].x + (TILE_WIDTH/2),
					m_currentTilesSelected.value[m_currentTilesSelected.value.length - 1].y + (TILE_WIDTH/2),
					10);
				
				m_lineOverlay.addChild(_line);
			}
		}
		
		public function drawLineBetween(_a:Point, _b:Point):void
		{
			var _line:Shape = new Shape();
			_line.graphics.lineStyle(2, 0xFF0000);
			_line.graphics.moveTo(_a.x, _a.y);
			_line.graphics.lineTo(_b.x, _b.y);
			m_lineOverlay.addChild(_line);
		}
		
		public function checkAdjacent(_a:Block, _b:Block):Boolean
		{
			var _aIndex:Point = findInBoard(_a);
			var _bIndex:Point = findInBoard(_b);
			
			if (Math.abs(_aIndex.x - _bIndex.x) <= 1 && Math.abs(_aIndex.y - _bIndex.y) <= 1)
			{
				return true;
			}
			return false;
		}
		
		public function findInBoard(_b:Block):Point
		{
			var _pos:Point = new Point();
			for (var _i:int = 0; _i < m_boardBlocks.length; _i++)
			{
				var _index:int = m_boardBlocks[_i].indexOf(_b);
				if (_index != -1)
				{
					_pos.x = _i;
					_pos.y = _index;
					break;
				}
			}
			return _pos;
		}
		
		public function onMouseUp(e:MouseEvent = null):void
		{
			trace(m_currentTilesSelected.value.toString());
			if (m_currentTilesSelected.value.length >= 3)
			{
				removeBlocks(m_currentTilesSelected.value);
				refillBoard();
				dropRows();
			}
			m_lineOverlay.removeChildren();
			m_currentTilesSelected = new FLXTriggeredArray();
			m_currentTilesSelected.changedSignal.addListener(onMovesChanged);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
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