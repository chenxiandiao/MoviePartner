package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import screens.Home;
//	import uiscreens.Home;
	import mainscreens.Root;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#4a4137")]
	public class MoviePartner extends Sprite
	{
		// We embed the "Ubuntu" font. Beware: the 'embedAsCFF'-part IS REQUIRED!!!
		[Embed(source="/../assets/fonts/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]
		private static const UbuntuRegular:Class;
		
		// Startup image for SD screens
		[Embed(source="/../system/startup.jpg")] private static var StartupImg:Class;
		[Embed(source="/../assets/bg.png")] private static var Background:Class;
		
		private var mStarling:Starling;
		
		public function MoviePartner()
		{
			// set general properties
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			
			// create the AssetManager, which handles all required assets for this resolution
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager();
			assets.verbose = Capabilities.isDebugger;
		
			assets.enqueue(
				appDir.resolvePath("audio"),
				appDir.resolvePath("fonts")
//				appDir.resolvePath("textures")
			); 
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
			// we display a startup image now and remove it below, when Starling is ready to go.
			// This is especially useful on iOS, where "Default.png" (or a variant) is displayed
			// during Startup. You can create an absolute seamless startup that way.
			// 
			// These are the only embedded graphics in this app. We can't load them from disk,
			// because that can only be done asynchronously (resulting in a short flicker).
			// 
			// Note that we cannot embed "Default.png" (or its siblings), because any embedded
			// files will vanish from the application package, and those are picked up by the OS!
			
			var startupImgClass:Class = StartupImg;
			var startupImg:Bitmap = new startupImgClass();
			StartupImg = null; // no longer needed!
			
			startupImg.x = 0;
			startupImg.y = 0;
			startupImg.width  = Constants.STAGE_WIDTH;
			startupImg.height = Constants.STAGE_HEIGHT;
			startupImg.smoothing = true;
			addChild(startupImg);
			
			
			// launch Starling
			var viewPort:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			mStarling = new Starling(Root, stage, viewPort);
			mStarling.stage.stageWidth  = Constants.STAGE_WIDTH;
			mStarling.stage.stageHeight = Constants.STAGE_HEIGHT;
			mStarling.simulateMultitouch  = false;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function(event:Object, app:Root):void
				{
					mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
					removeChild(startupImg);
					startupImg = null;
					
					var backgroundClass:Class = Background;
					var bgTexture:Texture = Texture.fromEmbeddedAsset(
						backgroundClass, false, false);
					
					app.start(bgTexture, assets);
//					app.start(bgTexture, null);
					mStarling.start();
				});
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated.
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(true); });
		}
	}
}