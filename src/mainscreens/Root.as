package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.system.System;
	
	import screens.MainHeadMenu;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.EmbeddedAssets;
	import utils.ProgressBar;
	
	/** The Root class is the topmost display object in your game. It loads all the assets
	 *  and displays a progress bar while this is happening. Later, it is responsible for
	 *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
	 *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
	 *  controls the high level behaviour of your game. */
	public class Root extends Screen
	{
		
		private var _leftMenu:LayoutGroup;
		private var _userPhontoBtn:Button;
		private var _movieWorldBtn:Button;
		private var _icon:ImageLoader;
		private static var sAssets:AssetManager;
		
		
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		public function Root()
		{
			//addEventListener(Menu.START_GAME, onStartGame);
			
			/*	加载一个默认的界面主题（否则所有控件需要手工定制皮肤）
			create the theme. this class will automatically pass skins to any
			Feathers component that is added to the stage. components do not
			have default skins, so you must always use a theme or skin the
			components manually. you should always create a theme immediately
			when your app starts up to ensure that all components are
			properly skinned. http://wiki.starling-framework.org/feathers/themes */
//			new MetalWorksMobileTheme();
			new ExtendedMetalWorksTheme();
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
		
		private function onStartIndexView():void
		{
			this.addChild(new Home());
//			this.layout = new HorizontalLayout();
//			this.layout = new VerticalLayout();
//			initLeftMenu();
		}
		
		public function initLeftMenu():void
		{
			
			this._leftMenu = new LayoutGroup();
			this._leftMenu.layout = new VerticalLayout();
			this._userPhontoBtn = new Button();
			this._userPhontoBtn.label = "hello";
			/*this._icon = new ImageLoader();
			this._icon.source = EmbeddedAssets.USER_PHOTO_ICON;
		
			this._icon.snapToPixels = true;
			this._icon.textureScale = this.dpiScale;
			this._icon.width = 158;
			this._userPhontoBtn.defaultIcon = this._icon;*/
			this._leftMenu.addChild(this._userPhontoBtn);
			this.addChild(this._leftMenu);
		}
		
		
		public static function get assets():AssetManager { return sAssets; }
	}
}