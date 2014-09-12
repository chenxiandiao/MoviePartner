package mainscreens
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.EmbeddedAssets;

	public class RegistorStepOneScreen extends Screen
	{
		private var _headerImg:ImageLoader;
		private var _userName:ImageLoader;
		private var _userNameInput:TextInput;
		private var _nextImg:ImageLoader;
		public function RegistorStepOneScreen()
		{
		}
		
		override protected function initialize():void
		{
			trace("RegistorStepOneScreen initialize");
			this._headerImg = new ImageLoader();
			this._headerImg.source = EmbeddedAssets.REGISTOR_HEADER_ICON;
			this._headerImg.width = EmbeddedAssets.REGISTOR_HEADER_ICON.width*this.dpiScale;
			this._headerImg.height = EmbeddedAssets.REGISTOR_HEADER_ICON.height*this.dpiScale;
			this.addChild(this._headerImg);
			
			this._userName = new ImageLoader();
			this._userName.source = EmbeddedAssets.REGISTOR_USERNAME_ICON;
			this._userName.width = EmbeddedAssets.REGISTOR_USERNAME_ICON.width*this.dpiScale;
			this._userName.height = EmbeddedAssets.REGISTOR_HEADER_ICON.height*this.dpiScale;
			this._userName.x = 414*this.dpiScale;
			this._userName.y = 297*this.dpiScale;
			this.addChild(this._userName);
			
			this._userNameInput = new TextInput();
			this._userNameInput.height = this._userName.height;
			this._userNameInput.prompt = "请输入手机号或邮箱";
			this._userNameInput.x = 651*this.dpiScale;
			this._userNameInput.y = 297*this.dpiScale;
//			this._userNameInput.nameList.add(ExtendedMetalWorksTheme.USER_NAME_TEXTINPUT);
		
			
			this.addChild(this._userNameInput);
			
			this._nextImg = new ImageLoader();
			this._nextImg.source = EmbeddedAssets.REGISTOR_NEXT_ICON;
			this._nextImg.width = EmbeddedAssets.REGISTOR_NEXT_ICON.width*this.dpiScale;
			this._nextImg.height = EmbeddedAssets.REGISTOR_NEXT_ICON.height*this.dpiScale;
			this._nextImg.x = 414*this.dpiScale;
			this._nextImg.y = 738*this.dpiScale;
			this._nextImg.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			this.addChild(this._nextImg);
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
				this.parent.addChild(new RegistorStepTwoScreen(this));
				this.parent.removeChildAt(0);
			}
		}
	}
}