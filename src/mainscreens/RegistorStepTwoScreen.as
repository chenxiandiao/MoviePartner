package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.EmbeddedAssets;

	public class RegistorStepTwoScreen extends Screen
	{
		private var _backBtn:Button;
		private var _prevScreen:Screen;
		private var _roleImg:ImageLoader;
		private var _roleTextInput:TextInput;
		private var roleChooseScreen:RoleChooseScreen;
		private var _quad:Quad;
		private var _yearList:List;
		public function RegistorStepTwoScreen(_prevScreen:Screen)
		{
			this._prevScreen = _prevScreen;
		}
		
		override protected function initialize():void
		{
			this._quad = new Quad(1024-80,768, 0x000000);
			this._quad.alpha = 0.1;
			
			this._backBtn = new Button();
			this._backBtn.label = "back";
			this._backBtn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			this.addChild(this._backBtn);
			
			this._roleImg = new ImageLoader();
			this._roleImg.source = EmbeddedAssets.REGISTOR_ROLE_ADD_ICON;
			this._roleImg.x = 1517*this.dpiScale;
			this._roleImg.y = 291*this.dpiScale;
			this._roleImg.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			this.addChild(this._roleImg);
			
			
			this._roleTextInput = new TextInput();
			this._roleTextInput.x = 569*this.dpiScale;
			this._roleTextInput.y = 291*this.dpiScale;
			this.addChild(this._roleTextInput);
			
			this.addEventListener("item choose",itemChooseTriggered);
			
			initYearList();
		}
		
		private function itemChooseTriggered(event:Event):void
		{
			trace("get the data from children screen:"+event.data.id);
			trace("RegistorStepTwoScreen item choose triggered");
			this.removeChild(this._quad);
			this.removeChild(this.roleChooseScreen);
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
				if(event.currentTarget==this._backBtn)
				{
					this.parent.addChild(this._prevScreen);
					this.parent.removeChildAt(0);
				}
				else if(event.currentTarget==this._roleImg)
				{
//					var roleChooseScreen:RoleChooseScreen = new RoleChooseScreen();
//					roleChooseScreen.x = this.stage.width;
//					this.addChild(roleChooseScreen);
//					var tween:Tween = new Tween(roleChooseScreen,0.5);
//					tween.animate("x",0);
//					Starling.juggler.add(tween);				
					
					//数据传递方式,事件传递
//					PopupWindowStyleOne();
//					PopupWindowStyleTwo();
//					PopUpWindowStyleThree();
					popCalendar();
				}
				
			
			}
		}
		
		private function popCalendar():void
		{
			
			this.showCallout(this._roleImg, Callout.DIRECTION_DOWN);
		}
		
		private function showCallout(origin:DisplayObject, direction:String):void
		{
			
			const callout:Callout = Callout.show(DisplayObject(this._yearList), origin, direction);
			callout.backgroundSkin = new Quad(100,100,0xffffff);
			//we're reusing the message every time that this screen shows a
			//callout, so we don't want the message to be disposed. we'll
			//dispose of it manually later when the screen is disposed.
			callout.disposeContent = false;
		}
		
		private function initYearList():void
		{
			var items:Array = [];
			for(var i:int = 0; i < 10; i++)
			{
				var item:Object = {text: "Item " + (i + 1).toString()};
				items[i] = item;
			}
			items.fixed = true;
			
			this._yearList = new List();
			this._yearList.height = 200;
			this._yearList.dataProvider = new ListCollection(items);
			this._yearList.typicalItem = {text: "Item 1000"};
			this._yearList.autoHideBackground = true;
//			this._yearList.nameList.add();
			this._yearList.itemRendererFactory = function():IListItemRenderer
			{
				
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				
				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "text";
				return renderer;
			};
		}
		
		private function PopupWindowStyleOne():void
		{
			roleChooseScreen = new RoleChooseScreen();
			roleChooseScreen.x = this.stage.width;
			roleChooseScreen.validate();
			trace(roleChooseScreen.width);
//			this.alpha = 0.1;
			this.addChild(this._quad);
			this.addChild(roleChooseScreen);
			var tween:Tween = new Tween(roleChooseScreen,0.5);
			tween.animate("x",1024-340-80);
			Starling.juggler.add(tween);
		}
		
		private function PopupWindowStyleTwo():void
		{
//			Transitions.register("shakyLinear",
//				function(ratio:Number):Number
//				{
//					if (ratio == 0.0 || ratio == 1.0) return ratio;
//					else return ratio + Math.sin(getTimer() / 100) * 0.1 - 0.05;
//				});
			
			Transitions.register("easeInCubic",
				function(ratio:Number):Number
				{
					return ratio * ratio * ratio * ratio;
				});	
			
			Transitions.register("easeInQuadratic",
				function(ratio:Number):Number
				{
					return ratio * ratio * ratio * ratio  * ratio;
				});			
			
			Transitions.register("easeOutCubic",
				function(ratio:Number):Number
				{
					var invRatio:Number = ratio - 1.0;
					return invRatio * invRatio * invRatio * invRatio  * invRatio * invRatio  * invRatio + 1;
				});	
			
			roleChooseScreen = new RoleChooseScreen();
			roleChooseScreen.x = 1024;
			roleChooseScreen.alpha = 0;
			this.addChild(roleChooseScreen);
//			var tween:Tween = new Tween(roleChooseScreen,0.5);
//			tween.animate("alpha",1);
//			Starling.juggler.add(tween);
			Starling.juggler.tween(roleChooseScreen,3, {
				transition: Transitions.EASE_IN,
				repeatCount: 1,
				reverse: true,
				alpha:1,
				onComplete: function():void {  },
				x: 0,
				y: 0,
				rotation:deg2rad(360)
			});
		}
		
		private function deg2rad(degree:Number):Number {
			return degree * (Math.PI / 180);
		}
		
		private function PopUpWindowStyleThree():void
		{
			var reusedCall:DelayedCall = new DelayedCall(spawnNewEnemy, 0.5);
			// repeatCount set to 0 repeats indefinitely
			reusedCall.repeatCount = 0;
			Starling.juggler.add(reusedCall);
		}
		private function spawnNewEnemy():void 
		{
			// Create a new enemy and add it to the display list
			roleChooseScreen = new RoleChooseScreen();
			addChild(roleChooseScreen);
		}
	}
}