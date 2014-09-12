package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.EmbeddedAssets;
	

	public class ConceptCreateScreen extends Screen
	{
		
		public function ConceptCreateScreen()
		{
		}
		override protected function initialize():void
		{
			trace("ConceptCreateScreen initialize");
			trace(this.name);
			PageIndex.movieCreateIndex = "ConceptCreateScreen";
			var btn:Button = new Button();
			
//			btn.defaultSkin = new Image(EmbeddedAssets.TEXTINPUT_BG_ICON);
//			var BUTTON_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 50, 50);
//			btn.defaultSkin =  new Scale9Image(new Scale9Textures(EmbeddedAssets.atlas.getTexture("button-up-skin"), BUTTON_SCALE9_GRID));
//			btn.nameList.add("my-custom-button");
			btn.label = "concept create";
			this.addChild(btn);
			btn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
		}
		
		public function onClickTriggered(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch( this);
			if( !touch )
			{
				// this should not happen.
				return;
			}
			if( touch.phase == TouchPhase.BEGAN )
			{
				var pointX:int = touch.globalX;
				var pointY:int = touch.globalY;
				trace("MovieCreate pointX:"+pointX+"pointY:"+pointY);
				this.parent.addChild(new ConceptTalkScreen());
				this.parent.removeChildAt(0);
			}
			
		}
	}
}