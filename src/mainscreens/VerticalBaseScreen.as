package mainscreens
{
	import feathers.controls.LayoutGroup;
	import feathers.display.TiledImage;
	import feathers.layout.VerticalLayout;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import utils.EmbeddedAssets;

	public class VerticalBaseScreen extends HeaderBaseScreen
	{
		public var _contentLayout:LayoutGroup;
		public var _contentBg:TiledImage;
		public var _urlRequest:URLRequest;
		public var _urlLoader:URLLoader;
		public function VerticalBaseScreen()
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
			
			this._contentLayout = new LayoutGroup();
			this._contentLayout.layout = new VerticalLayout();
			this._contentLayout.x = 12.5;
			this._contentLayout.y = 65;
			
			
			this.addChild(this._contentLayout);
		}
	}
}