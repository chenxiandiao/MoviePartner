package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
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
		public function RegistorStepTwoScreen(_prevScreen:Screen)
		{
			this._prevScreen = _prevScreen;
		}
		
		override protected function initialize():void
		{
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
		}
		
		private function itemChooseTriggered(event:Event):void
		{
			trace("get the data from children screen:"+event.data.id);
			trace("RegistorStepTwoScreen item choose triggered");	
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
					PopupWindowStyleOne();
//					PopupWindowStyleTwo();
//					PopUpWindowStyleThree();
				}
				
			
			}
		}
		
		private function PopupWindowStyleOne():void
		{
			roleChooseScreen = new RoleChooseScreen();
			roleChooseScreen.x = this.stage.width;
			this.addChild(roleChooseScreen);
			var tween:Tween = new Tween(roleChooseScreen,0.5);
			tween.animate("x",0);
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
			var reusedCall:DelayedCall = new DelayedCall(spawnNewEnemy, 3);
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