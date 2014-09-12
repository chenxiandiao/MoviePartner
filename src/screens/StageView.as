package screens
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import flash.display.Scene;
	import flash.events.TimerEvent;
	import flash.net.FileReference;
	import flash.utils.Timer;
	
	import starling.events.Event;
	
	public class StageView extends Screen
	{
		private var button:Button;
		private var _list:List;
		private var _navigator:ScreenNavigator = null;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		public function StageView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			this.originalWidth = 1024;
			this.originalHeight = 768;
			
			// create a button and give it some text to display.
			/*this.button = new Button();
			this.button.label = "Click Me";
			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			this.addChild(this.button);
			
			this.button.validate();
			
			this.button.x = 0;
			this.button.y = 0;*/
			
			this.layout = new HorizontalLayout();
			
			addMenuList();
			addContent();
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
		}
		
		protected function button_triggeredHandler(event:Event):void
		{
			const label:Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a nice day.";
			Callout.show(label, this.button);
		}
		
		protected function addContent():void
		{
			this._navigator = new ScreenNavigator();	
			this._navigator.addScreen("script",new ScreenNavigatorItem(ScriptScreen));
			this._navigator.addScreen("scene",new ScreenNavigatorItem(SceneInfoScreen));
			this._navigator.showScreen("script");
			this._navigator.addEventListener(FeathersEventType.LONG_PRESS,longPress_enterFrameHandler);
			this.addChild(this._navigator);
		}
		
		private function longPress_enterFrameHandler():void
		{
			trace("long press");
			this._navigator.showScreen("script");
		}
		protected function addMenuList():void
		{
			var items:Array = [];
			var role:Object = {text:"角色",id:"role"};
			var property:Object = {text:"道具",id:"property"};
			var clothes:Object = {text:"服装",id:"clothes"};
			var scene:Object = {text:"场次",id:"scene"};
			items.push(role);
			items.push(property);
			items.push(clothes);
			items.push(scene);
			items.fixed = true;
			
			this._list = new List();
			this._list.dataProvider = new ListCollection(items);
			this._list.typicalItem = {text: "Item 1000"};
			this._list.isSelectable = true
			this._list.allowMultipleSelection = false
			this._list.hasElasticEdges = true;
			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			this._list.clipContent = false;
			this._list.autoHideBackground = true;
			this._list.itemRendererFactory = function():IListItemRenderer
			{
				
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				
				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;
				
				renderer.labelField = "text";
				return renderer;
			};
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChild(this._list);
		}
		
		private function list_changeHandler(event:Event):void
		{
			const selectedIndices:Vector.<int> = this._list.selectedIndices;
			var selectedItem:Object = this._list.selectedItem;
			var id:String = selectedItem["id"];
			trace("List onChange:", selectedIndices.length > 0 ? selectedIndices : this._list.selectedIndex);
			if(id!="scene")
			{
				this._navigator.showScreen("script");
			}
			else
			{
				this._navigator.showScreen("scene");
			}
//			var fileRef:FileReference = new FileReference();
//			fileRef.browse();
//			fileRef.addEventListener(Event.SELECT, selectHandler);
			
		}
	}
}