package mainscreens
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	
	import utils.EmbeddedAssets;

	public class HeaderBaseScreen extends Screen
	{
		
		private var _headerImg:ImageLoader;
		public var _progress:ImageLoader;
		
		public function HeaderBaseScreen()
		{
		}
		override protected function initialize():void
		{
			initHeader();
		}
		private function initHeader():void
		{
			this._headerImg = new ImageLoader();
			this._headerImg.source = EmbeddedAssets.MOVIE_CREATE_HEADER_BG_ICON;
			this.addChild(this._headerImg);
			
			this._progress = new ImageLoader();
			this._progress.source = EmbeddedAssets.MOVIE_CREATE_PROGRESS_ICON;
			this._progress.x = 200;
			this._progress.y = 5;
			this.addChild(this._progress);		
			
		}
	}
}