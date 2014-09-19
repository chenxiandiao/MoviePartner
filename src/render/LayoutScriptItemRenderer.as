package render
{
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	
	public class LayoutScriptItemRenderer extends LayoutGroupListItemRenderer
	{
		
			public function LayoutScriptItemRenderer()
			{
				
			}
		
			protected var _label:Label;
			private var _quad:Quad;
			protected var _padding:Number = 0;
			
			private var _backgroundSkin:DisplayObject;
			
			public function get backgroundSkin():DisplayObject
			{
				return this._backgroundSkin;
			}
			
			public function set backgroundSkin(value:DisplayObject):void
			{
				if(this._backgroundSkin == value)
				{
					return;
				}
				if(this._backgroundSkin)
				{
					this.removeChild(this._backgroundSkin, true);
				}
				this._backgroundSkin = value;
				if(this._backgroundSkin)
				{
					this.addChildAt(this._backgroundSkin, 0);
				}
				this.invalidate(INVALIDATION_FLAG_SKIN);
			}
			
			public function get padding():Number
			{
				return this._padding;
			}
			
			public function set padding(value:Number):void
			{
				if(this._padding == value)
				{
					return;
				}
				this._padding = value;
				this.invalidate(INVALIDATION_FLAG_LAYOUT);
			}
			
			override protected function initialize():void
			{
				this.layout = new AnchorLayout();
				
				var labelLayoutData:AnchorLayoutData = new AnchorLayoutData();
				labelLayoutData.top = 0;
				labelLayoutData.right = 0;
				labelLayoutData.bottom = 0;
				labelLayoutData.left = 0;
				this._quad = new Quad(40,15, 0xffffff);
				this._label = new Label();
				this._label.layoutData = labelLayoutData;
//				this._backgroundSkin = this._quad;
//				this.addChild(this._quad);
				
//				backgroundSkin(_backgroundSkin);
//				if(this._backgroundSkin)
//				{
//					this.addChildAt(this._backgroundSkin, 0);
//					this.addChild(this._backgroundSkin);
//				}
				this.addChild(this._label);
			}
			
			override protected function commitData():void
			{
				if(this._data && this._owner)
				{
					this._label.text = this._data.text;
				}
				else
				{
					this._label.text = null;
				}
			}
			
			override protected function preLayout():void
			{
				var labelLayoutData:AnchorLayoutData = AnchorLayoutData(this._label.layoutData);
				labelLayoutData.top = this._padding;
				labelLayoutData.right = this._padding;
				labelLayoutData.bottom = this._padding;
				labelLayoutData.left = this._padding;
				if( this._backgroundSkin )
				{
					this._backgroundSkin.width = 0;
					this._backgroundSkin.height = 0;
				}
			}
			
			override protected function postLayout():void
			{
				if( this._backgroundSkin )
				{
					this._backgroundSkin.width = this.actualWidth;
					this._backgroundSkin.height = this.actualHeight;
				}
			}
		}
}