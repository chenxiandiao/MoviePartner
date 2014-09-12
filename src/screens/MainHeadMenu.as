package screens
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MainHeadMenu extends Screen
	{
		[Embed(source="/../assets/images/index/menu.png")] private static var CImgBG:Class;
		[Embed(source="/../assets/images/index/movie_partner.png")] private static var CImgLogo:Class;
		
		public function MainHeadMenu()
		{
			super();
			this.width = 1024;
			this.height = 62;
		}
		
		override protected function initialize():void
		{
			this.addChild(new Image(Texture.fromEmbeddedAsset(CImgBG, false, false)));
			var imgLogo:Image = new Image(Texture.fromEmbeddedAsset(CImgLogo, false, false));
			imgLogo.x = 10;
			imgLogo.y = 15;
			this.addChild(imgLogo);
		}
		
		protected function button_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith( "showMenu", true );
		}
	}
}