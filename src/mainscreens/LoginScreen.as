package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.display.TiledImage;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.text.TextFormat;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.ConstantsUtil;
	import utils.EmbeddedAssets;

	public class LoginScreen extends Screen
	{
		private var _headerImg:ImageLoader;
		private var _content:LayoutGroup;
		private var _contentGroup:LayoutGroup;
		private var _contentBg:TiledImage;
		private var _inputAreaBg:ImageLoader;
		private var _labelUsername:Label;
		private var _labelPassword:Label;
		private var _inputUsername:TextInput;
		private var _inputPassword:TextInput;
		private var _labelRegistorLink:Label;
		private var _btnLogin:Button;
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		public function LoginScreen()
		{
			this._urlRequest = new URLRequest();
			this._urlLoader = new URLLoader();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			initHeader();
			initContent();
		}
		
		private function initHeader():void
		{
			this._headerImg = new ImageLoader();
			this._headerImg.source = EmbeddedAssets.LOGIN_HEADER_ICON;
			this._headerImg.width = EmbeddedAssets.LOGIN_HEADER_ICON.width;
			this._headerImg.height = EmbeddedAssets.LOGIN_HEADER_ICON.height;
			this.addChild(this._headerImg);

		}
		
		private function initContent():void
		{
			this._content = new LayoutGroup();
			this._content.x = 0;
			this._content.y = 53;
			
			this._contentBg = new TiledImage(EmbeddedAssets.LOGIN_CONTENT_BG_ICON);
			this._contentBg.x = 12.5;
			this._contentBg.y = 10;
			this._content.addChild(this._contentBg);
		
			this._inputAreaBg = new ImageLoader();
			this._inputAreaBg.source = EmbeddedAssets.LOGIN_AREA_BG_ICON;
			this._inputAreaBg.x = 206
			this._inputAreaBg.y = 90.5
			this._content.addChild(this._inputAreaBg);
			
			this._labelUsername = new Label();
			this._labelUsername.text = "账号:";
			this._labelUsername.textRendererFactory = labelTextRenderer;
			this._labelUsername.x = 274;
			this._labelUsername.y = 105;
			this._content.addChild(this._labelUsername);
			
			this._labelPassword = new Label();
			this._labelPassword.text = "密码:";
			this._labelPassword.textRendererFactory = labelTextRenderer;
			this._labelPassword.x = 274;
			this._labelPassword.y = 160;
			this._content.addChild(this._labelPassword);
			
			this._inputUsername = new TextInput();
			this._inputUsername.x = 330;
			this._inputUsername.y = 105;
			this._inputUsername.maxChars = 20;
			this._inputUsername.prompt = "请输入手机号或邮箱";
			this._inputUsername.promptFactory = labelTextRenderer;
			this._inputUsername.nameList.add("user-name-inputtext");
			this._content.addChild(this._inputUsername);
			
			this._inputPassword = new TextInput();
			this._inputPassword.x = 330;
			this._inputPassword.y = 160;
			this._inputPassword.maxChars = 20;
			this._inputPassword.prompt = "4-20位数字或字母,区分大小写";
			this._inputPassword.promptFactory = labelTextRenderer;
			this._inputPassword.nameList.add("user-name-inputtext");
			this._content.addChild(this._inputPassword);
				
			this._labelRegistorLink = new Label();
			this._labelRegistorLink.text = "没有账号?立即注册";
			this._labelRegistorLink.textRendererFactory = function():ITextRenderer{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "微软雅黑", 18, 0xFF503F);
				textRenderer.embedFonts = false;
				textRenderer.isHTML = false;
				return textRenderer;
			}
			this._labelRegistorLink.x = 206;
			this._labelRegistorLink.y = 220;
			this._content.addChild(this._labelRegistorLink);
			
			this._btnLogin = new Button();
			this._btnLogin.x = 206;
			this._btnLogin.y = 300;
			var icon:ImageLoader = new ImageLoader();
			icon.source = EmbeddedAssets.LOGIN_BTN_ICON;
			this._btnLogin.width = EmbeddedAssets.LOGIN_BTN_ICON.width;
			this._btnLogin.height = EmbeddedAssets.LOGIN_BTN_ICON.height;
			this._btnLogin.defaultIcon = icon;
			
			this._btnLogin.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			this._content.addChild(this._btnLogin);
			
			this.addChild(this._content);
		}
		
		private function labelTextRenderer():ITextRenderer{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = new TextFormat( "微软雅黑", 18, 0xBBBBBB);
			textRenderer.embedFonts = false;
			textRenderer.isHTML = false;
			return textRenderer;
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
				
			}
		}
		
		
		private function loginRequest():void 
		{
			this._urlRequest.url = ConstantsUtil.SERVERURL;
			this._urlRequest.method = URLRequestMethod.POST;
			var params:Object = new Object();
			params.username = this._inputUsername.text;
			params.password = this._inputPassword.text;
			this._urlRequest.data = params;
			this._urlLoader.load(this._urlRequest);
			this._urlLoader.addEventListener(flash.events.Event.COMPLETE,completeHandler);
		}
		
		private function completeHandler(event:flash.events.Event):void
		{
			trace( event.currentTarget.data ) ;
		}
	}
}