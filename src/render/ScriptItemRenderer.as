package render
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.layout.VerticalLayout;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ScriptItemRenderer extends LayoutGroupListItemRenderer
	{
		protected var touchID:int = -1
		protected var _label:Label;
		protected var _scriptItemGroup:LayoutGroup;
		protected var _list:List
		[Embed( source = "../assets/images/script/line.png" )]
		private var LineImage:Class;
		private var _lineImage:Image;
		
		private static const HELPER_POINT:Point = new Point();
		public function ScriptItemRenderer()
		{
			
		}
		
		override protected function initialize():void
		{
			this.addEventListener( TouchEvent.TOUCH, touchHandler );
			this.addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			this.layout = new VerticalLayout();
			if(!this._scriptItemGroup)
			{
				this._scriptItemGroup = new LayoutGroup();
				this._scriptItemGroup.height = 40;
				this._scriptItemGroup.layout = GlobalLayout.hLayoutCenter();
				this.addChild(this._scriptItemGroup);
			}
			if(!this._label)
			{
				this._label = new Label();
				this._scriptItemGroup.addChild(this._label);
			}
			if(!this._lineImage)
			{
				_lineImage = Image.fromBitmap(new LineImage());
//				_lineImage.visible = false;
				this.addChild(this._lineImage);
			}
			
		}
		override protected function preLayout():void
		{
		}
		
		override protected function commitData():void
		{
			if(this._data && this._owner && this._label)
			{
				this._label.text = this._data.text;
			}
			else
			{
				this._label.text = null;
			}
		}
		
		private function touchHandler( event:TouchEvent ):void
		{
			if( !this._isEnabled )
			{
				// if we were disabled while tracking touches, clear the touch id.
				this.touchID = -1;
				return;
			}
			
			if( this.touchID >= 0 )
			{
				// a touch has begun, so we'll ignore all other touches.
				
				var touch:Touch = event.getTouch( this, null, this.touchID );
				if( !touch )
				{
					// this should not happen.
					return;
				}
				
				if( touch.phase == TouchPhase.ENDED )
				{
					touch.getLocation( this.stage, HELPER_POINT );
					var isInBounds:Boolean = this.contains( this.stage.hitTest( HELPER_POINT, true ) );
					if( isInBounds )
					{
						this.isSelected = true;
						trace("selected");
					}
					
					// the touch has ended, so now we can start watching for a new one.
					this.touchID = -1;
				}
				return;
			}
			else
			{
				// we aren't tracking another touch, so let's look for a new one.
				
				touch = event.getTouch( this, TouchPhase.BEGAN );
				if( !touch )
				{
					// we only care about the began phase. ignore all other phases.
					return;
				}
				
				// save the touch ID so that we can track this touch's phases.
				this.touchID = touch.id;
			}
		}
		
		private function removedFromStageHandler( event:Event ):void
		{
			this.touchID = -1;
		}
	}
}