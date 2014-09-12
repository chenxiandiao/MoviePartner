package screens
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TabBar;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	
	import flash.events.Event;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import starling.events.Event;
	

	public class ScriptBreakHome extends Screen
	{
		private var _tabBar:TabBar = null;
		
		private var _roleButton:Button = null;
		private var _roleList:List = null;
		private var _propertyButton:Button = null;
		private var _propertyList:List = null;
		private var _sceneButton:Button = null;
		private var _sceneList:List = null;
		public function ScriptBreakHome()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);	
		}
		
		public function initializeHandler():void
		{
//			this._tabBar = new TabBar();
//			this._tabBar.direction = TabBar.DIRECTION_VERTICAL;
//			this._tabBar.width = 400;
//			this._tabBar.dataProvider = new ListCollection(
//				[
//					{ label: "One" },
//					{ label: "Two" },
//					{ label: "Three" },
//				]);
//			this.addChild(this._tabBar);
			
			this.layout = new VerticalLayout();
			_roleButton = new Button();
			_roleButton.label = "角色"
			_roleList = new List();
			_propertyButton = new Button();
			_propertyButton.label = "道具";
			_propertyList = new List();
			_sceneButton = new Button();
			_sceneButton.label = "场次";
			_sceneList = new List();
			addBtnAndList(_roleButton,_roleList);
			addBtnAndList(_propertyButton,_propertyList);
			addBtnAndList(_sceneButton,_sceneList);
			
			
		}
		
		private function addBtnAndList(btn:Button,list:List):void
		{
			
			btn.addEventListener(starling.events.Event.TRIGGERED,onRoleButtonTriggered);
			//			_roleGroup.addChild(_roleButton);
			this.addChild(btn);
			var items:Array = [];
			for(var i:int = 0; i < 5; i++)
			{
				var item:Object = {text: "Item " + (i + 1).toString()};
				items[i] = item;
			}
			items.fixed = true;
			
			list.width = stage.stageWidth;
			list.dataProvider = new ListCollection(items);
			list.isSelectable = true;
			list.allowMultipleSelection = false;
			list.hasElasticEdges = false;
			list.typicalItem = {text: "Item 1000"};
			//optimization to reduce draw calls.
			//only do this if the header or other content covers the edges of
			//the list. otherwise, the list items may be displayed outside of
			//the list's bounds.
			list.clipContent = false;
			list.autoHideBackground = true;
			
			list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				
				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;
				
				renderer.labelField = "text";
				return renderer;
			};
			this.addChild(list);
			//			this._roleGroup.addChild(this._roleList);
			//			this.addChild(_roleGroup);
		}
		
		private function onRoleButtonTriggered(event:starling.events.Event):void
		{
			const button:Button = Button(event.currentTarget);
			if(button.label == "角色")
			{
				this._roleList.visible = !this._roleList.visible;
				this._roleList.includeInLayout = !this._roleList.includeInLayout;
			}
			else if(button.label =="道具")
			{
				this._propertyList.visible = !this._propertyList.visible
				this._propertyList.includeInLayout = !this._propertyList.includeInLayout;
			}
			else if(button.label == "场次")
			{
				this._sceneList.visible = !this._sceneList.visible;
				this._sceneList.includeInLayout = !this._sceneList.includeInLayout;
			}
//			login();
			socketConnect();
		}
		
		private function login():void
		{
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = "http://127.0.0.1:8080/iMovieServer/as";
			urlRequest.method = URLRequestMethod.POST;
			var params:Object = new Object();
			params.username = "cxd";
			params.password = "123";
			urlRequest.data = params;
			var loader:URLLoader = new URLLoader();
			loader.load(urlRequest);
			loader.addEventListener(flash.events.Event.COMPLETE,completeHandler);
		}
		
		
		private function socketConnect():void
		{
			trace("socket connect");
			var socket:Socket = new Socket();
			socket.connect("10.10.15.250",8992);
			var json:Object = new Object();
			socket.writeUTF("hello world");
		}
		
		private function completeHandler(event:flash.events.Event):void
		{
			trace( event.currentTarget.data ) ;
		}
	}
}