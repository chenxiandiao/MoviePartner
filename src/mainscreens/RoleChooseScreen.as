package mainscreens
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.EmbeddedAssets;

	public class RoleChooseScreen extends Screen
	{
		private var _bg:ImageLoader;
		public function RoleChooseScreen()
		{
		}
		
		override protected function initialize():void
		{
			
			this._bg = new ImageLoader();
			this._bg.source = EmbeddedAssets.REGISTOR_ROLE_CHOOSE_ICON;
			this.addChild(this._bg);
			this._bg.addEventListener(TouchEvent.TOUCH,onClickTriggered);
		}
		
		private function onClickTriggered(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch( this);
			if( !touch )
			{
				// this should not happen.
				return;
			}
			if( touch.phase == TouchPhase.BEGAN )
			{	
				trace("RoleChosoeScreen choose role");
				var data:Object = new Object();
				data.id = "1";
				this.dispatchEventWith("item choose",true,data);
			}
		}		
	}
}