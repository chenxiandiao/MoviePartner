package screens
{
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class SceneInfoScreen extends Screen
	{
		
		[Embed(source="../assets/images/close.png")]
		public static const CloseImg:Class;
		
		[Embed(source="../assets/images/pen_blue.png")]
		public static const EditImg:Class;
		
		
		private var _label:Label = null;
		public function SceneInfoScreen()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		public function initializeHandler():void
		{
			this.layout = new HorizontalLayout();
			_label = new Label();
			_label.text = "helo world";
			this.addChild(_label);
			var image:Image = Image.fromBitmap(new CloseImg());
			var editImage:Image = Image.fromBitmap(new EditImg());
			editImage.width = 16;
			editImage.height = 16;
			this.addChild(image);
			this.addChild(editImage);
			image.addEventListener(TouchEvent.TOUCH,onCloseTriggered);
			editImage.addEventListener(TouchEvent.TOUCH,onEditTriggered);
			
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
				this.dispatchEventWith(FeathersEventType.LONG_PRESS,true);
			}
		}
		
		private function onEditTriggered(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch( this);
			if( !touch )
			{
				// this should not happen.
				return;
			}
			if( touch.phase == TouchPhase.ENDED )
			{
				trace("edit image click");
				PopUpManager.addPopUp( new BaseUIScreen(), false, false , function():DisplayObject
				{
					var quad:Quad = new Quad(100, 100, 0xff0000);
					quad.alpha = 0.75;
					return quad;
				});
				

			}
			
		}
		
	}
}