package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.text.ITextEditorViewPort;
	import feathers.controls.text.TextFieldTextEditorViewPort;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextFormat;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.ConstantsUtil;
	import utils.EmbeddedAssets;
	

	public class ConceptCreateScreen extends ScrollBaseScreen
	{
//		private var _headerImg:ImageLoader;
//		private var _progress:ImageLoader;
//		private var _content:LayoutGroup;
//		private var _contentBg:TiledImage;
		private var _conceptContent:LayoutGroup;
		private var _conceptIdeaLabel:Label;
		private var _conceptCategoryLabel:Label;
		private var _conceptImageLabel:Label;
		private var _conceptDescLabel:Label;
		private var _conceptIdeaInput:TextInput;
		private var _conceptCategoryBtn1:Button;
		private var _conceptCategoryBtn2:Button;
		private var _conceptCategoryBtn3:Button;
		private var _conceptImageBtn:Button;
		private var _conceptDescTextArea:TextArea;
		private var _conceptPublishBtn:Button;
		private var _file:FileReference;
		private var _imagePath:String = "";
		private var _movieType:String;
		
		private var _conceptIdeaLayout:LayoutGroup;
		private var _conceptCategoryLayout:LayoutGroup;
		private var _conceptImageLayout:LayoutGroup;
		private var _conceptImage:ImageLoader;
		private var _conceptDescLayout:LayoutGroup;
		private var _conceptPublishLayout:LayoutGroup;
		
		
		public function ConceptCreateScreen()
		{
			super();
		}
		override protected function initialize():void
		{
			trace("ConceptCreateScreen initialize");
			trace(this.name);
			super.initialize();
			PageIndex.movieCreateIndex = "ConceptCreateScreen";
			initOwnContentV();
		}
		
		private function initOwnContentV():void{
			this._conceptContent = new LayoutGroup();
			this._conceptContent.layout = new VerticalLayout();
			initConceptIdea();
			initConceptCategory();
			initConceptImage();
			initConceptDesc();
			initConceptPublish();
			this._scrollContainer.addChild(this._conceptContent);
		}
		
		private function initConceptIdea():void
		{
			this._conceptIdeaLayout = new LayoutGroup();
			this._conceptIdeaLayout.layout =  ideaHorizontalLayout();
			this._conceptIdeaLabel = initLabelV("构想主题:",this._conceptIdeaLayout);
			
			this._conceptIdeaInput = new TextInput();
			this._conceptIdeaInput.nameList.add(ExtendedMetalWorksTheme.INPUT_BG);
			
			this._conceptIdeaLayout.addChild(this._conceptIdeaInput);
			this._conceptContent.addChild(this._conceptIdeaLayout);
		}
		
		private function initConceptCategory():void
		{
			this._conceptCategoryLayout = new LayoutGroup();
			this._conceptCategoryLayout.layout = categoryHorizontalLayout();
			this._conceptCategoryLabel = initLabelV("构想类别:",this._conceptCategoryLayout);
			this._conceptCategoryBtn1 = initStateButtonV(EmbeddedAssets.MOVIE_CREATE_CATEGORY_MOVIE_UP_ICON,EmbeddedAssets.MOVIE_CREATE_CATEGORY_MOVIE_ICON,this._conceptCategoryLayout);
			this._conceptCategoryBtn2 = initStateButtonV(EmbeddedAssets.MOVIE_CREATE_CATEGORY_TV_UP_ICON,EmbeddedAssets.MOVIE_CREATE_CATEGORY_TV_ICON,this._conceptCategoryLayout)
			this._conceptCategoryBtn3 = initStateButtonV(EmbeddedAssets.MOVIE_CREATE_CATEGORY_NET_UP_ICON,EmbeddedAssets.MOVIE_CREATE_CATEGORY_NET_ICON,this._conceptCategoryLayout);
			this._conceptContent.addChild(this._conceptCategoryLayout);
		}
		
		private function initConceptImage():void
		{
			this._conceptImageLayout = new LayoutGroup();
			this._conceptImageLayout.layout = categoryHorizontalLayout();
			this._conceptImageLabel = initLabelV("构想图片",this._conceptImageLayout);
			this._conceptImage = new ImageLoader();
			this._conceptImage.source = EmbeddedAssets.MOVIE_CREATE_CONCEPT_IMAGE_ICON;
//			this._conceptImage.source= "http://10.10.15.250:8080/iMovierServerB/img/2014091610383645315.png";
			this._conceptImage.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			this._conceptImageLayout.addChild(this._conceptImage);
			this._conceptContent.addChild(this._conceptImageLayout);
		}
		
		private function initConceptDesc():void
		{
			this._conceptDescLayout = new LayoutGroup();
			this._conceptDescLayout.layout = categoryHorizontalLayout();
			this._conceptDescLabel = initLabelV("构想说明",this._conceptDescLayout);
			this._conceptDescTextArea = new TextArea();
			this._conceptDescTextArea.nameList.add(ExtendedMetalWorksTheme.TEXTAREA_BG);
			this._conceptDescTextArea.text = "hello";
			this._conceptDescLayout.addChild(this._conceptDescTextArea);
			this._conceptContent.addChild(this._conceptDescLayout);
			
		}
		
		private function initConceptPublish():void
		{
			this._conceptPublishLayout = new LayoutGroup();
			this._conceptPublishLayout.layout = publishHorizontalLayout();
			this._conceptPublishBtn = initButtonV(EmbeddedAssets.MOVIE_CREATE_CONCEPT_PUBLISH_ICON,this._conceptPublishLayout);
			this._conceptContent.addChild(this._conceptPublishLayout);
		}
		
		private function ideaHorizontalLayout():HorizontalLayout{
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.paddingLeft = 112;
			layout.paddingTop = 112;
			layout.gap = 20;
			return layout;
		}
		
		private function categoryHorizontalLayout():HorizontalLayout{
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.paddingLeft = 112;
			layout.paddingTop = 30;
			layout.gap = 20;
			return layout;
		}
		
		private function publishHorizontalLayout():HorizontalLayout{
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.paddingLeft = 570;
			layout.paddingTop = 30;
			layout.paddingBottom = 50;
			return layout;
		}
		
		private function initLabel(text:String, x:int, y:int, parent:LayoutGroup):Label		
		{
			var label:Label = new Label();
			label.text = text;
			label.x = x;
			label.y = y;
			label.textRendererFactory = labelTextRenderer;
			parent.addChild(label);
			return label;
		}
		
		private function initLabelV(text:String,parent:LayoutGroup):Label{
			var label:Label = new Label();
			label.text = text;
			label.textRendererFactory = labelTextRenderer;
			parent.addChild(label);
			return label;
		}
		
		private function initStateButtonV(texture:Texture,disableTexture:Texture,parent:LayoutGroup):Button
		{
			var btn:Button = new Button();
			btn.defaultIcon = new Image(texture);
			btn.width = texture.width;
			btn.height = texture.height;
			btn.disabledIcon = new Image(disableTexture);
			parent.addChild(btn); 
			btn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			return btn;
		}
		
		private function initStateButton(texture:Texture,disableTexture:Texture, x:int, y:int, parent:LayoutGroup):Button
		{
			var btn:Button = new Button();
			btn.x = x;
			btn.y = y;
			btn.defaultIcon = new Image(texture);
			btn.width = texture.width;
			btn.height = texture.height;
			btn.disabledIcon = new Image(disableTexture);
			parent.addChild(btn); 
			btn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			return btn;
		}
		
		private function initButtonV(texture:Texture, parent:LayoutGroup):Button
		{
			var btn:Button = new Button();
			btn.defaultIcon = new Image(texture);
			btn.width = texture.width;
			btn.height = texture.height;
			parent.addChild(btn); 
			btn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			return btn;
		}
		
		private function initButton(texture:Texture, x:int, y:int, parent:LayoutGroup):Button
		{
			var btn:Button = new Button();
			btn.x = x;
			btn.y = y;
			btn.defaultIcon = new Image(texture);
			btn.width = texture.width;
			btn.height = texture.height;
			parent.addChild(btn); 
			btn.addEventListener(TouchEvent.TOUCH,onClickTriggered);
			return btn;
		}
		
		private function labelTextRenderer():ITextRenderer{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = new TextFormat( "微软雅黑", 18, 0x4B4B4B);
			textRenderer.embedFonts = false;
			textRenderer.isHTML = false;
			return textRenderer;
		}
		
		
		public function onClickTriggered(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch( this);
			if (!touch )
			{
				// this should not happen.
				return;
			}
			if( touch.phase == TouchPhase.BEGAN )
			{	
				if (event.currentTarget == this._conceptCategoryBtn1
					||event.currentTarget == this._conceptCategoryBtn2
					||event.currentTarget == this._conceptCategoryBtn3)
				{
					categoryChange(event.currentTarget);
				}
				else if (event.currentTarget == this._conceptImage)
				{
					var fileRef:FileReference = new FileReference();
					fileRef.browse();
					fileRef.addEventListener(flash.events.Event.SELECT, selectHandler);
					fileRef.addEventListener(flash.events.Event.COMPLETE, uploadCompleteHandler);
					fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadCompleteDataHandler)
				}
				else if (event.currentTarget == this._conceptPublishBtn)
				{
					trace("click");
					publishConcept();
				}
//				var pointX:int = touch.globalX;
//				var pointY:int = touch.globalY;
//				trace("MovieCreate pointX:"+pointX+"pointY:"+pointY);
//				this.parent.addChild(new ConceptTalkScreen());
//				this.parent.removeChildAt(0);
			}
			
		}
		
		private function categoryChange(btn:Object):void{
			if (btn == this._conceptCategoryBtn1)
			{
				this._conceptCategoryBtn1.isEnabled = false;
				this._conceptCategoryBtn2.isEnabled = true;
				this._conceptCategoryBtn3.isEnabled = true;
				this._movieType = "1";
			}
			else if (btn == this._conceptCategoryBtn2)
			{
				this._conceptCategoryBtn1.isEnabled = true;
				this._conceptCategoryBtn2.isEnabled = false;
				this._conceptCategoryBtn3.isEnabled = true;
				this._movieType = "2";
			}
			else if (btn== this._conceptCategoryBtn3)
			{
				this._conceptCategoryBtn1.isEnabled = true;
				this._conceptCategoryBtn2.isEnabled = true;
				this._conceptCategoryBtn3.isEnabled = false;
				this._movieType = "3";
			}
		}
		
		private function publishConcept():void{
			this._urlRequest = new URLRequest();
			this._urlRequest.url = ConstantsUtil.SERVERURL + "PublishConceive";
			this._urlRequest.method = URLRequestMethod.POST;
			var params:URLVariables = new URLVariables();
			params.UserName = ConstantsUtil.USERNAME;
			params.Theme = this._conceptIdeaInput.text;
			params.MovieType = this._movieType;
			params.Description = this._conceptDescTextArea.text;
			params.Picture = this._imagePath;
			this._urlRequest.data = params;
			this._urlLoader.load(this._urlRequest);
			this._urlLoader.addEventListener(flash.events.Event.COMPLETE,publishCompleteHandler);
		}
		
		private function selectHandler(event:flash.events.Event):void {
			this._file = FileReference(event.target);
			this._urlRequest = new URLRequest();
			this._urlRequest.url =  ConstantsUtil.SERVERURL + "UploadImgAll";
			this._file.upload(this._urlRequest,"UpImgFile");
			trace("selectHandler: name=" + this._file.name);
		}
		
		private function uploadCompleteHandler(event:flash.events.Event):void {
			trace("completeHandler:");
		}
	
		private function uploadCompleteDataHandler(event:DataEvent):void {
			var data:String = event.data;
			var result:Object = JSON.parse(data);
			if (result.type=="check_ok")
			{
				this._imagePath = result.content.imgName;
				var imagePath:String =  (result.content.imgUrl as String).replace("\\","/");
				trace("imagePath:"+imagePath);
				this._conceptImage.addEventListener(flash.events.Event.COMPLETE,imageLoaderCompleteHandler);
				this._conceptImage.source =imagePath;
			}
			trace("uploadCompleteData: " + event.data);
			trace(this._imagePath);
		}
		
		private function publishCompleteHandler(event:flash.events.Event):void
		{
			var data:String = event.currentTarget.data as String;
			var result:Object = JSON.parse(data);
			trace(data);
			if (result.type=="check_ok")
			{
				
			}else{
				
			}
		}
		
		private function imageLoaderCompleteHandler(event:starling.events.Event):void
		{
			
//			this._conceptImage.validate();
//			this._conceptImageLayout.validate();
//			this._conceptContent.validate();
//			this._contentBg.height = this._content.height-30;
//			this._contentBg.scaleY = 3;
		}
	}
}