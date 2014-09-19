package mainscreens
{
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.display.TiledImage;
	import feathers.layout.AnchorLayout;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import utils.EmbeddedAssets;

	public class ScrollBaseScreen extends HeaderBaseScreen
	{
		public var _scrollContainer:ScrollContainer;
		public var _contentBg:TiledImage;
		public var _urlRequest:URLRequest;
		public var _urlLoader:URLLoader;
		public function ScrollBaseScreen()
		{	
			this._urlRequest = new URLRequest();
			this._urlLoader = new URLLoader();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			initContent();
		}
		
		private function initContent():void
		{
			this._contentBg = new TiledImage(EmbeddedAssets.LOGIN_CONTENT_BG_ICON);
			this._contentBg.x = 12.5;
			this._contentBg.y = 63;
			this._contentBg.height = EmbeddedAssets.LOGIN_CONTENT_BG_ICON.height-15;
			this.addChild(this._contentBg);
			
			this._scrollContainer = new ScrollContainer();
			this._scrollContainer.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			this._scrollContainer.height =  710;
			this._scrollContainer.x = 12.5;
			this._scrollContainer.y = 65;
		
			
			this.addChild(this._scrollContainer);
		}
	}
}