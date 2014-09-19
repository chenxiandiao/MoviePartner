package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.TextInput;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.ILayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.ConstantsCss;

	public class ProjectCreateScreen extends VerticalBaseScreen
	{
		[Embed(source="/../assets/images/moviecreate/project-create/back.png")]
		public  var BackClass:Class;
		private var _backImage:Image;
		
		private var _prefScreen:Screen;
		private var _projectHeaderLayout:LayoutGroup;
		private var _projectHeaderLabel:Label;
		private var _projectNameLabel:Label;
		private var _projectNameLayout:LayoutGroup;
		private var _projectNameInput:TextInput;
		private var _projectMoneyLabel:Label;
		private var _projectMoneyLayout:LayoutGroup;
		private var _projectMoneyInput:TextInput;
//		private var _scrollContainer2:ScrollContainer;
		private static const CONTENTWIDTH:int = 1024 - 80;
		public function ProjectCreateScreen(_prefScreen:Screen)
		{
			this._prefScreen = _prefScreen;
			super();
		}
		override protected function initialize():void
		{
			super.initialize();
			PageIndex.movieCreateIndex = "ProjectCreateScreen";
			initOwnContent();
		}
		
		private function initOwnContent():void
		{
			initBackImage();
			initProjectHeader();
			initProjectName();
			initProjectMoney();
//			this._scrollContainer2 = new ScrollContainer();
//			this._scrollContainer2.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
//			this._scrollContainer2.height =  710;
//			this._scrollContainer2.x = 12.5;
//			this._scrollContainer2.y = 65;
//			this._scrollContainer.addChild(this._projectContent);
			this.addChild(this._contentLayout);
		}
		
		private function initBackImage():void
		{
			this._backImage = Image.fromBitmap(new BackClass());
			this._contentLayout.addChild(this._backImage);
			this._backImage.addEventListener(TouchEvent.TOUCH,onClickTriggered);
		}
		
		private function initProjectHeader():void
		{
			this._projectHeaderLayout = new LayoutGroup();
			this._projectHeaderLayout.width = CONTENTWIDTH;
			var layout:HorizontalLayout  = new HorizontalLayout();
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.paddingTop = 20;
			this._projectHeaderLayout.layout = layout;
			this._projectHeaderLabel = new Label();
			this._projectHeaderLabel.text = "项目信息";
			this._projectHeaderLabel.textRendererFactory = ConstantsCss.headerLabelTextRenderer;
			this._projectHeaderLayout.addChild(this._projectHeaderLabel);
			this._contentLayout.addChild(this._projectHeaderLayout);
		}
		
		private function initProjectName():void
		{
			this._projectNameLayout = new LayoutGroup();
			this._projectNameLayout.width = CONTENTWIDTH;
			this._projectNameLayout.layout =  nameHorizontalLayout();
			this._projectNameLabel = initLabel("构想主题:",this._projectNameLayout);
			
			this._projectNameInput = new TextInput();
			this._projectNameInput.nameList.add(ExtendedMetalWorksTheme.INPUT_BG);
			
			this._projectNameLayout.addChild(this._projectNameInput);
			
			this._contentLayout.addChild(this._projectNameLayout);
		}
		
		private function initProjectMoney():void
		{
			this._projectMoneyLayout = new LayoutGroup();
			this._projectMoneyLayout.width = CONTENTWIDTH;
			this._projectMoneyLayout.layout =  nameHorizontalLayout();
			this._projectMoneyLabel = initLabel("预计经费:",this._projectMoneyLayout);
			
			this._projectMoneyInput = new TextInput();
			this._projectMoneyInput.nameList.add(ExtendedMetalWorksTheme.INPUT_BG);
			
			this._projectMoneyLayout.addChild(this._projectMoneyInput);
			
			this._contentLayout.addChild(this._projectMoneyLayout);
		}
		private function initLabel(text:String,parent:LayoutGroup):Label{
			var label:Label = new Label();
			label.text = text;
			label.textRendererFactory = ConstantsCss.labelTextRenderer;
			parent.addChild(label);
			return label;
		}
		private function nameHorizontalLayout():HorizontalLayout{
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.paddingTop = 30;
			layout.gap = 20;
			return layout;
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
				if (this._prefScreen is ConceptTalkScreen){
					(this._prefScreen as ConceptTalkScreen)._nextScreen = this;
				}
				this.parent.addChild(this._prefScreen);
				this.parent.removeChildAt(0);	
			}
		}
	}
}