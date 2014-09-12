package uiscreens
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.display.TiledImage;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.ProgressBar;
	import utils.XmlReader;
	
	/** The Root class is the topmost display object in your game. It loads all the assets
	 *  and displays a progress bar while this is happening. Later, it is responsible for
	 *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
	 *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
	 *  controls the high level behaviour of your game. */
	public class Home extends Sprite
	{
		private static var sAssets:AssetManager;
		private var loader:Loader = new Loader();
		public var _xmlReader:XmlReader = new XmlReader();
		private var screenArray:Array = [];
		public function Home()
		{
			//addEventListener(Menu.START_GAME, onStartGame);
			
			/*	加载一个默认的界面主题（否则所有控件需要手工定制皮肤）
			create the theme. this class will automatically pass skins to any
			Feathers component that is added to the stage. components do not
			have default skins, so you must always use a theme or skin the
			components manually. you should always create a theme immediately
			when your app starts up to ensure that all components are
			properly skinned. http://wiki.starling-framework.org/feathers/themes */
			new MetalWorksMobileTheme();
		}
		
		public function start(background:Texture, assets:AssetManager):void
		{
			// the asset manager is saved as a static variable; this allows us to easily access
			// all the assets from everywhere by simply calling "Root.assets"
			sAssets = assets;
			
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			var bg:TiledImage = new TiledImage(background);
			bg.width = Constants.STAGE_WIDTH;
			bg.height = Constants.STAGE_HEIGHT;
			this.addChildAt(bg, 0);
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			var progressBar:ProgressBar = new ProgressBar(175, 20);
			progressBar.x = (Constants.STAGE_WIDTH  - progressBar.width)  / 2;
			progressBar.y = (Constants.STAGE_HEIGHT - progressBar.height) / 2;
			addChild(progressBar);
			
			assets.loadQueue(function onProgress(ratio:Number):void
			{
				progressBar.ratio = ratio;
				
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 
				if (ratio == 1)
				{
					Starling.juggler.delayCall(function():void
					{
						progressBar.removeFromParent(true);
						onStartIndexView();
						
						// now would be a good time for a clean-up 
						System.pauseForGCIfCollectionImminent(0);
						System.gc();
					}, 0.15);
				}
			});
		}
		
		private function loadImageDynamic():void
		{
			this._xmlReader.LoadXML("textures/all.xml");
			while(screenArray.length==0)
			{
				screenArray = this._xmlReader.getScreenArray();
				for(var i:int=0;i<screenArray.length;i++)
				{
					loader.load(new URLRequest("textures/"+screenArray[i]+".png"));
					loader.contentLoaderInfo.addEventListener ( flash.events.Event.COMPLETE, onComplete );
				}
			}
			
			
		}
		
		private function onComplete ( e:flash.events.Event):void
		{
			trace(e.target.name);
			// grab the loaded bitmap
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			
			// create a texture from the loaded bitmap
			var texture:Texture = Texture.fromBitmap ( loadedBitmap );
			
		}
		
		
		private function onStartIndexView():void
		{
//			this.addChild(new BaseScreen("textures/movie_world.xml","textures/movie_world.png"));
			this.addChild(new BaseScreen("textures/movie_world.xml","textures/movie_world.png"));
//			this.addChild(new BaseScreen("textures/movie_world.xml","movie_world"));
		}
		
		public static function get assets():AssetManager { return sAssets; }
	}
}