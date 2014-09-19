package screens
{
	
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import render.LayoutScriptItemRenderer;
	import render.ScriptItemRenderer;
	import render.SuperScriptItemRenderer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.EmbeddedAssets;

	
	public class ScriptScreen  extends Screen
	{
		
//		private var shape:Shape = null;
//		private var _line:Shape = null;
		private var mouseDownPoint:Point;
		private var mouseUpPoint:Point;
		private var _scrollText:ScrollText;
		private var _label:Label = null;
		private var _list:List = null;
		private var _scrollContainer:ScrollContainer = null;
		private var _lineAndScriptGroup:LayoutGroup = null;
		private var _scriptGroup:LayoutGroup = null;
		private var useWidth:int  = 0;
		private var touchCount:int = 0;
		private var _colorQuad:Quad;
		private var _quad:Quad;
		private var _downQuad:Quad;
		public function ScriptScreen()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			
		}
		
		public function initializeHandler():void
		{
			EmbeddedAssets.initialize();
			this._colorQuad = new Quad(10,10,0xff0000);
			this._quad = new Quad(10,700, 0xffffff);
			this._downQuad = new Quad(10,10,0x000000);
			useWidth = stage.stageWidth;
			var w:int = stage.stageWidth;
			
			_scrollContainer = new ScrollContainer();
			_scrollContainer.width = stage.stageWidth;
			_scrollContainer.height = stage.stageHeight-150;
			_scrollContainer.layout = new AnchorLayout();
			_scrollContainer.scrollBarDisplayMode = Scroller.VERTICAL_SCROLL_BAR_POSITION_RIGHT;
			_scrollContainer.snapScrollPositionsToPixels = true;
			
			_scrollContainer.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			_lineAndScriptGroup = new LayoutGroup();
			_scriptGroup = new LayoutGroup();
			_scriptGroup.layout = new VerticalLayout();

//			for(var i:int = 0;i<100;i++)
//			{
//				this._label = new Label();
//				_label.text = i+"听着这歌，小雨的眼里泛起了泪花，小豆看着小雨，百感交集，他相信他找到";
//				_label.height = 30;
//				scriptGroup.addChild(_label);
//			}
			
			var items:Array = [];
			for(var i:int = 0; i < 150; i++)
			{
				var item:Object = {text: "Item " + (i + 1).toString()};
				items[i] = item;
			}
			items.fixed = true;
			
//			var sectionListCollection:ListCollection = new ListCollection();
//			for(var i:int = 0;i<10;i++)
//			{
//				var sectionItem:Object = new Object();
//				sectionItem.sectionName = "section "+ i;
//				sectionListCollection.addItem(sectionItem)
//			}
			
			this._list = new List();
			this._list.width = stage.stageWidth;
			this._list.dataProvider = new ListCollection(items);
//			this._list.typicalItem = {text: "Item 1000"};
			this._list.isSelectable = true;
			this._list.allowMultipleSelection = false;
			this._list.hasElasticEdges = false;
			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			this._list.clipContent = false;
			this._list.autoHideBackground = true;
			
		
			this._list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
//				
//				//enable the quick hit area to optimize hit tests when an item
//				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "text";
				return renderer;
			};
//			this._list.backgroundSkin = this._colorQuad;
		
//			this._list.itemRendererFactory = scriptListItemRendererFactory;
//			this._list.itemRendererFactory = function():IListItemRenderer
//			{
//				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
//				renderer.isQuickHitAreaEnabled = true;
//				renderer.labelField = "text";
//				return renderer;
//			};
			this._scriptGroup.addChild(_list);

			this._lineAndScriptGroup.addChild(this._scriptGroup);
			
			this._scrollContainer.addChild(this._lineAndScriptGroup);
//			scrollContainer.addChild(_list);
			this.addChild(this._scrollContainer);
			mouseDownPoint = new Point();
			mouseUpPoint = new Point();
		}
		
		
		
		private function mouseDownHandler( event:MouseEvent ):void
		{
			mouseDownPoint.x =  Starling.current.nativeStage.mouseX;
			mouseDownPoint.y =  Starling.current.nativeStage.mouseY;
			trace(mouseDownPoint.x+"  "+mouseDownPoint.y);
		}
		
		private function mouseMoveHandler( event:MouseEvent):void
		{
//			currentPoint.x =  Starling.current.nativeStage.mouseX;
//			currentPoint.y =  Starling.current.nativeStage.mouseY;
//			trace(currentPoint.x+"  "+currentPoint.y);
		}
		
		private function mouseUpHandler( event:MouseEvent):void
		{
			mouseUpPoint.x =  Starling.current.nativeStage.mouseX;
			mouseUpPoint.y =  Starling.current.nativeStage.mouseY;
			trace(mouseUpPoint.x+"  "+mouseUpPoint.y);
			var yOffset:int = mouseUpPoint.y - mouseDownPoint.y;
			var xOffset:int = mouseUpPoint.x - mouseDownPoint.x;
			trace("x:"+xOffset+"y:"+yOffset);
			if(yOffset>-5&&yOffset<5&&(xOffset>5||xOffset<-5))
			{
				trace("绘制分割线");

				var p1:Point = new Point(0,mouseUpPoint.y+Math.abs(yOffset));
				var p2:Point = new Point(useWidth,mouseUpPoint.y+Math.abs(yOffset));
				var p3:Point = new Point(useWidth, mouseUpPoint.y+Math.abs(yOffset)+2);
				var p4:Point = new Point(0, mouseUpPoint.y+Math.abs(yOffset)+2);
					
//				drawSeparationLine(p1,p2,p3,p4);
			}
		}
		
		private function drawSeparationLine(p1:Point,p2:Point,p3:Point,p4:Point):void
		{
			trace("绘制分割线");
//			_line = new Shape();
//			_line.graphics.beginFill(0xc72046);
//			_line.graphics.moveTo(p1.x, p1.y);
//			_line.graphics.lineTo(p2.x, p2.y);
//			_line.graphics.lineTo(p3.x, p3.y);
//			_line.graphics.lineTo(p4.x, p4.y);
//			_line.graphics.lineTo(p1.x, p1.y);
//			this._lineAndScriptGroup.addChild(this._line);
		}
		
		private function touchHandler(event:TouchEvent):void
		{
//			event.t
//			trace("touch"+touchCount);
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
				var p1:Point = new Point(0,localPos.y);
				var p2:Point = new Point(useWidth,localPos.y);
				var p3:Point = new Point(useWidth,localPos.y+2);
				var p4:Point = new Point(0,localPos.y+2);
				trace("Touched object at position x:" + localPos.x+"y:"+localPos.y);
				drawSeparationLine(p1,p2,p3,p4);
			}
		}
		
		protected function scriptListItemRendererFactory():IListItemRenderer
		{
//			var renderer:SuperScriptItemRenderer = new SuperScriptItemRenderer();
//			renderer.backgroundSkin = this._quad;
//			renderer.downBackgroundSkin = this._downQuad;
//			var renderer:ScriptItemRenderer = new ScriptItemRenderer();
//			renderer.addEventListener(MouseEvent.MOUSE_DOWN,list_changeHandler);
			var renderer:LayoutScriptItemRenderer = new LayoutScriptItemRenderer();
//			renderer.backgroundSkin = this._quad;
			return renderer;
		}
		
		private function list_changeHandler(event:Event):void
		{
			const selectedIndices:Vector.<int> = this._list.selectedIndices;
			trace("List onChange:", selectedIndices.length > 0 ? selectedIndices : this._list.selectedIndex);
		}
	}
}