
package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.ConstantsUtil;
	import utils.EmbeddedAssets;

	public class Home extends Screen
	{
		private var _bg:TiledImage;
		private var _content:LayoutGroup;
		private var _leftMenu:LayoutGroup;
		private var _userPhontoBtn:Button;
		private var _movieWorldBtn:Button;
		private var _movieCreateBtn:Button;
		private var _movieTaskBtn:Button;
		private var _movieMsgBtn:Button;
		private var _movieTeamBtn:Button;
		private var _movieArBtn:Button;
		private var _movieOtherBtn:Button;
		private var _navigator:ScreenNavigator;
		
		
		public function Home()
		{
//			new MetalWorksMobileTheme();
//			new ExtendedMetalWorksTheme();
		}
		
		override protected function initialize():void
		{
			EmbeddedAssets.initialize();
			_bg = new TiledImage(EmbeddedAssets.HOME_BG_ICON);
			this.addChild(_bg);
			_content = new LayoutGroup();
			_content.layout = new HorizontalLayout();
			initLeftMenu();
			initLeftContent();
			this.addChild(_content);
		}
		
		public function initLeftMenu():void
		{
			
			this._leftMenu = new LayoutGroup();
			this._leftMenu.layout = new VerticalLayout();
			
			this._userPhontoBtn = initLeftBtn(this._userPhontoBtn,EmbeddedAssets.USER_PHOTO_ICON);
			this._movieWorldBtn = initLeftBtn(this._movieWorldBtn,EmbeddedAssets.MOVIE_WORLD_ICON);
			this._movieCreateBtn = initLeftBtn(this._movieCreateBtn,EmbeddedAssets.MOVIE_CREATE_ICON);
//			this._movieCreateBtn.label = "hello";
			this._movieTaskBtn = initLeftBtn(this._movieTaskBtn,EmbeddedAssets.MOVIE_TASK_ICON);
			this._movieMsgBtn = initLeftBtn(this._movieMsgBtn,EmbeddedAssets.MOVIE_MSG_ICON);
			this._movieTeamBtn = initLeftBtn(this._movieTeamBtn,EmbeddedAssets.MOVIE_TEAM_ICON);
			this._movieArBtn = initLeftBtn(this._movieArBtn,EmbeddedAssets.MOVIE_AR_ICON);
			this._movieOtherBtn = initLeftBtn(this._movieOtherBtn,EmbeddedAssets.MOVIE_OTHER_ICON);
			
			this._leftMenu.addChild(this._userPhontoBtn);
			this._leftMenu.addChild(this._movieWorldBtn);
			this._leftMenu.addChild(this._movieCreateBtn);
			this._leftMenu.addChild(this._movieTaskBtn);
			this._leftMenu.addChild(this._movieMsgBtn);
			this._leftMenu.addChild(this._movieTeamBtn);
			this._leftMenu.addChild(this._movieArBtn);
			this._leftMenu.addChild(this._movieOtherBtn);
			_content.addChild(this._leftMenu);
			
			setBtnClickListener();
			
			
			//			this._icon.addEventListener(Event.COMPLETE,loader_completeHandler);
			//			this._icon.source = "http://127.0.0.1:8080/iMovieServer/static/pic/plan_cut.png";
		}
		
	
		private function initLeftBtn(btn:Button,texture:Texture):Button
		{
			btn = new Button();
			var icon:ImageLoader = new ImageLoader();
	
			icon.source = texture;
			icon.snapToPixels = true;
			btn.width = texture.width;
			btn.height = texture.height
			btn.defaultIcon = icon;
			return btn;
		}
		
		private function initLeftContent():void
		{
			this._navigator = new ScreenNavigator();
			
			this._navigator.addScreen(ConstantsUtil.USERLOGIN,new ScreenNavigatorItem(LoginScreen));
			this._navigator.addScreen(ConstantsUtil.HOMECONTENT,new ScreenNavigatorItem(HomeContentScreen));
			this._navigator.addScreen(ConstantsUtil.MOVIECREATE,new ScreenNavigatorItem(MovieCreateScreen));

			this._navigator.showScreen(ConstantsUtil.HOMECONTENT);
			
			_content.addChild(this._navigator);
		}
		
		private function setBtnClickListener():void
		{
			this._userPhontoBtn.addEventListener(TouchEvent.TOUCH,onClickTriggered);			
			this._movieCreateBtn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			this._movieWorldBtn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
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
				if(event.currentTarget == this._movieCreateBtn)
				{				
					this._navigator.showScreen(ConstantsUtil.MOVIECREATE);
				}
				else if(event.currentTarget == this._movieWorldBtn)
				{
					this._navigator.showScreen(ConstantsUtil.HOMECONTENT);
				}
				else if(event.currentTarget == this._userPhontoBtn)
				{
					this._navigator.showScreen(ConstantsUtil.USERLOGIN);
				}
			}
		}
		
//		private function loader_completeHandler(event:Event):void
//		{
//			this._icon.validate();
//			trace("complete:"+this._icon.width);
//		}
	}
}