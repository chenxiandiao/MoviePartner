package screens
{
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class BaseUIScreen extends Screen
	{
		private var _label:Label = null;
		[Embed(source="/../system/startup.jpg")] private static var StartupImg:Class;
		
		[Embed(source="../assets/images/close.png")]
		public static const CloseImg:Class;
		
		public function BaseUIScreen()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		public function initializeHandler():void
		{
			this.width = Constants.STAGE_WIDTH;
			this.height = Constants.STAGE_HEIGHT;
				
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
			this.layout = horizontalLayout;
			
			_label = new Label();
			_label.text = "添加道具";
			this.addChild(_label);
			var closeImg:Image = Image.fromBitmap(new CloseImg());
			closeImg.addEventListener(TouchEvent.TOUCH,onCloseTriggered);
			this.addChild(closeImg);
			
			var startupImg:Image = Image.fromBitmap(new StartupImg());
			
			startupImg.width  = Constants.STAGE_WIDTH/2;
			startupImg.height = Constants.STAGE_HEIGHT;
			addChild(startupImg);
		}
		
		private function onCloseTriggered(event:TouchEvent):void
		{
			
			var touch:Touch = event.getTouch( this);
			if( !touch )
			{
				// this should not happen.
				return;
			}
			if( touch.phase == TouchPhase.ENDED )
			{
				trace("close image click");
				PopUpManager.removePopUp(this);
			}
		}
	}
}