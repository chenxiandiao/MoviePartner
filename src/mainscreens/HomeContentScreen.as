package mainscreens
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	
	import utils.EmbeddedAssets;

	public class HomeContentScreen extends Screen
	{
		private var _bg:ImageLoader;
		public function HomeContentScreen()
		{
		}
		
		override protected function initialize():void
		{
			trace("HomeContentScreen initialize");
			this._bg = new ImageLoader;
			this._bg.source = EmbeddedAssets.MOVIE_WORLD_CONTENT_ICON;
			
			this.addChild(this._bg);
		}
	}
}