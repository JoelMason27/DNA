package com.util 
{
	/**
	 * ...
	 * @author Joel Mason
	 */
	public  class Utility 
	{
		public static function getRandomCharacter():String
		{
			var randomCharCode : int = 65 + Math.floor(26*Math.random());
			return String.fromCharCode(randomCharCode);
		}
		
		public static function getBasePairChar():String
		{
			var char:String = "";
			var randomInt = Math.floor(4 * Math.random());
			switch (randomInt) 
			{
				case 0:
					char = "A";
					break;
				case 1:
					char = "T";
					break;
				case 2:
					char = "G";
					break;
				case 3:
					char = "C";
					break;
				default:
					break;
			}
			return char;
		}

		
	}

}