package 
{
	import cerebralfix.felix.FLXMain;
	import cerebralfix.zill.flash.ZILFlashUIRoot;
	import cerebralfix.zill.izil.IZILUIRoot;
	import cerebralfix.zill.ui.ZILDisplayData;
	import cerebralfix.zill.ui.ZILUIManager;
	import cerebralfix.zill.ui.ZILUIRoot;
	import com.data.enum.UIEnum;
	import com.sociodox.theminer.TheMiner;  
	/**
	 * ...
	 * @author Joel Mason
	 */
	public class DNAMain extends FLXMain
	{
		
		public function DNAMain() 
		{
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			stage.addChild(new TheMiner()); 
			var root:IZILUIRoot = new ZILFlashUIRoot();
			ZILUIManager.instance.initialize(root);
			registerScreens();
			ZILUIManager.instance.showScreen(UIEnum.GAME);
		}
		
		private function registerScreens():void
		{
			var _screen:ZILDisplayData = new ZILDisplayData();
			//_screen.tag = UIEnum.MAIN_MENU;
			//_screen.objectClassName = "com.view.screen.ScreenMainMenu";
			//ZILUIManager.instance.registerScreen(_screen);
			
			//_screen = new ZILDisplayData();
			_screen.tag = UIEnum.GAME;
			_screen.objectClassName = "com.view.screen.ScreenGame";
			ZILUIManager.instance.registerScreen(_screen);
		}
		
	}

}