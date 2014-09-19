package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.StageText;
	import flash.text.TextFormat;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	import utils.ConstantsUtil;
	import utils.EmbeddedAssets;

	public class ConceptTalkScreen extends HeaderBaseScreen
	{
		[Embed(source="/../assets/images/moviecreate/concept-talk/concept-line.png")]
		public  var _lineImageClass:Class;	
		[Embed(source="/../assets/images/moviecreate/concept-talk/project-create.png")]
		public  var _projectCreateClass:Class;	
		private var _leftBg:Image;
		private var _conceptImage:ImageLoader;
		private var _leftContentLayout:LayoutGroup;
		private var _scrollContainer:ScrollContainer;
		private var _conceptIdeaLabel:Label;
		private var _conceptCreaterLabel:Label;
		private var _conceptTimeLabel:Label;
		private var _conceptDescLabel:Label;
		
		
		private var _lineImage:Image;
		private static const LEFTWIDTH:int = 319;
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		
		private var _createProjectImage:Image;
		private var _rightScrollContainer:ScrollContainer;
		public var _nextScreen:Screen;
		public function ConceptTalkScreen()
		{
			this._urlRequest = new URLRequest();
			this._urlLoader = new URLLoader();
		}
		
		override protected function initialize():void
		{
			trace("ConceptTalkScreen initialize");
			super.initialize();
			PageIndex.movieCreateIndex = "ConceptTalkScreen";
			initLeftContent();
			initRightContent();
		}
		
		private function initRightContent():void{
			this._createProjectImage = Image.fromBitmap(new _projectCreateClass());
			this._createProjectImage.x = 830;
			this._createProjectImage.y = 63;
			this.addChild(this._createProjectImage);
			_createProjectImage.addEventListener(TouchEvent.TOUCH,onClickTriggered)
		}
		
		private function initLeftContent():void{
			this._leftBg = new Image(EmbeddedAssets.CONCEPT_CONTENT_BG_ICON);
			this._leftBg.x = 12.5;
			this._leftBg.y = 63;
			this._leftBg.height = EmbeddedAssets.CONCEPT_CONTENT_BG_ICON.height - 15;
			this.addChild(this._leftBg);
			
			this._scrollContainer = new ScrollContainer();
			this._scrollContainer.x = 12.5;
			this._scrollContainer.y = 65;
			this._scrollContainer.height = 710;
			this._scrollContainer.width = LEFTWIDTH;
			this._scrollContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			
			this._leftContentLayout = new LayoutGroup();
			this._leftContentLayout.layout = conceptContentViewLayout();
			initConceptImage();
			addLineImage();
			initConceptIdeaLabel();
			addLineImage();
			initConceptCreaterLabel();
			addLineImage();
			initConceptTimeLabel();
			addLineImage();
			initConceptDescLabel();
			addLineImage();
			this._scrollContainer.addChild(this._leftContentLayout);
			this.addChild(this._scrollContainer);
			requestGetConceptInfo();
		}
		private function conceptContentViewLayout():VerticalLayout{
			var layout:VerticalLayout = new VerticalLayout;
			layout.padding = 15;
			layout.gap = 10;
			return layout;
		}
		
		private function addLineImage():void
		{
			
			this._lineImage = Image.fromBitmap(new _lineImageClass());
//			this._lineImage = new Image(EmbeddedAssets.CONCEPT_CONTENT_LINE_ICON);
			this._leftContentLayout.addChild(this._lineImage);
		}
		
		private function initConceptImage():void
		{
			this._conceptImage = new ImageLoader();
			this._conceptImage.source = EmbeddedAssets.USER_PHOTO_ICON;
			this._leftContentLayout.addChild(this._conceptImage);
		}
		
		private function initConceptIdeaLabel():void
		{
			this._conceptIdeaLabel = new Label();
			this._conceptIdeaLabel.width = LEFTWIDTH;
//			this._conceptIdeaLabel.text = "构想主题:  一览众山小一览众山小一览众山小一览众山小一览众山小一览众山小一览众山小一览众山小一览众山小";
			this._conceptIdeaLabel.textRendererFactory = labelTextRenderer;
			this._leftContentLayout.addChild(this._conceptIdeaLabel);
		}
		
		private function initConceptCreaterLabel():void
		{
			this._conceptCreaterLabel = new Label();
			this._conceptCreaterLabel.width = LEFTWIDTH;
//			this._conceptCreaterLabel.text = "发布人:chen";
			this._conceptCreaterLabel.textRendererFactory = labelTextRenderer;
			this._leftContentLayout.addChild(this._conceptCreaterLabel);
		}
		
		private function initConceptTimeLabel():void
		{
			this._conceptTimeLabel = new Label();
			this._conceptTimeLabel.width = LEFTWIDTH;
//			this._conceptTimeLabel.text = "发布时间:2014-09-17";
			this._conceptTimeLabel.textRendererFactory = labelTextRenderer;
			this._leftContentLayout.addChild(this._conceptTimeLabel);
		}
		
		private function initConceptDescLabel():void
		{
			this._conceptDescLabel = new Label();
			this._conceptDescLabel.width = LEFTWIDTH;
//			this._conceptDescLabel.text = "构想简介:hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world";
			this._conceptDescLabel.textRendererFactory = labelTextRenderer;
			this._leftContentLayout.addChild(this._conceptDescLabel);
		}
		
		private function labelTextRenderer():ITextRenderer{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "微软雅黑";
			textFormat.size = 15;
			textFormat.color = 0x4B4B4B;
			textFormat.letterSpacing = 1;
			textFormat.leading = 4;
//			textRenderer.textFormat = new TextFormat( "黑体", 15, 0x4B4B4B);
			textRenderer.textFormat  = textFormat;
			textRenderer.embedFonts = false;
			textRenderer.wordWrap = true;
			textRenderer.isHTML = false;
			return textRenderer;
		}
		
		private function requestGetConceptInfo():void
		{
			this._urlRequest.url = ConstantsUtil.SERVERURL + "queryProjectByUser";
			this._urlRequest.method = URLRequestMethod.POST;
			var params:URLVariables = new URLVariables();
			params.UserName = ConstantsUtil.USERNAME;
			this._urlRequest.data = params;
			this._urlLoader.load(this._urlRequest);
			this._urlLoader.addEventListener(Event.COMPLETE,requestCompleteHandler);
			this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,requestErrorHandler);
		}
		
		private function requestCompleteHandler(event:flash.events.Event):void
		{
			var data:String = event.currentTarget.data as String;
			var result:Object = JSON.parse(data);
			trace(data);
			if (result.type=="check_ok")
			{
				if (result.content.length>=1)
				{
					this._conceptIdeaLabel.text = "发布构想: " + result.content[0].theme;
					this._conceptCreaterLabel.text = "发布人: " + result.content[0].userName;
					this._conceptTimeLabel.text = "发布时间: " + result.content[0].creattime;
					this._conceptDescLabel.text = "构想说明:" + result.content[0].description;
				}
				
			}else{
				
			}
		}
		
		private function requestErrorHandler(event:flash.events.Event):void
		{
			trace("error");
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
				if(this._nextScreen!=null)
				{
					this.parent.addChild(this._nextScreen);
				}
				else
				{
					this.parent.addChild(new ProjectCreateScreen(this));					
				}
				this.parent.removeChildAt(0);
			}
		}
	}
}