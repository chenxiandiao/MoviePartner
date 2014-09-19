package render
{
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class SuperScriptItemRenderer extends FeathersControl implements IListItemRenderer
	{
		public static const STATE_HOVER:String = "hover";
		public static const STATE_UP:String = "up";
		public static const STATE_DOWN:String = "down";
		private var _backgroundSkin:DisplayObject;
		private var _downBackgroundSkin:DisplayObject;
		protected var _label:Label;
		
		protected var _index:int = -1;
		
		private var _currentState:String = STATE_UP;
		
		protected var touchID:int = -1;
		
		private static const HELPER_POINT:Point = new Point();
		private var _currentBackgroundSkin:DisplayObject;
		
		public function SuperScriptItemRenderer() 
		{
			
		}
		
		
		public function get currentState():String
		{
			return this._currentState;
		}
		
		public function set currentState( value:String ):void
		{
			if( this._currentState == value )
			{
				return;
			}
			this._currentState = value;
			this.invalidate( INVALIDATION_FLAG_STATE );
		}
		
		public function get index():int
		{
			return this._index;
		}
		
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _owner:List;
		
		public function get owner():List
		{
			return this._owner;
		}
		
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _data:Object;
		
		public function get data():Object
		{
			return this._data;
		}
		
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _isSelected:Boolean;
		
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}
		
		protected var _padding:Number = 0;
		
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
			if(!this._label)
			{
				this._label = new Label();
				this.addChild(this._label);
			}
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			trace("click");
			if(!this._isEnabled)
			{
				// if we were disabled while tracking touches, clear the touch id.
				this.touchID = -1;
				
				// the button should return to the up state, if it is disabled.
				// you may also use a separate disabled state, if you prefer.
				this.currentState = STATE_UP;
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
//					this.currentState = STATE_UP;
					
					// the touch has ended, so now we can start watching for a new one.
//					this.touchID = -1;
					touch.getLocation( this.stage, HELPER_POINT );
					var isInBounds:Boolean = this.contains( this.stage.hitTest( HELPER_POINT, true ) );
					if( isInBounds )
					{
						this.currentState = STATE_HOVER;
					}
					else
					{
						this.currentState = STATE_UP;
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
				if( touch )
				{
					this.currentState = STATE_DOWN;
					
					// save the touch ID so that we can track this touch's phases.
					this.touchID = touch.id;
					return;
				}
				
				// this touch didn't begin, so maybe it's a hover.
				
				touch = event.getTouch( this, TouchPhase.HOVER );
				if( touch )
				{
					this.currentState = STATE_HOVER;
					return;
				}
				
				// the only remaining possibility: the hover has ended.
				
				this.currentState = STATE_UP;
			}
			
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			this.touchID = -1;
		}
		
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			var stateInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_STATE );
			var skinInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SKIN );
			if(dataInvalid)
			{
				this.commitData();
			}
			if( stateInvalid || skinInvalid )
			{
				this.updateCurrentBackground();
			}
			this.autoSizeIfNeeded();
			this.layoutChildren();
		}
		
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			
			this._label.width = this.explicitWidth - 2 * this._padding;
			this._label.height = this.explicitHeight - 2 * this._padding;
			this._label.validate();
			
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				newWidth = this._label.width + 2 * this._padding;
				var backgroundWidth:Number = this._backgroundSkin.width;
				if(backgroundWidth > newWidth)
				{
					newWidth = backgroundWidth;
				}
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				newHeight = this._label.height + 2 * this._padding;
				var backgroundHeight:Number = this._backgroundSkin.height;
				if(backgroundHeight > newWidth)
				{
					newWidth = backgroundHeight;
				}
			}
			
			
			
			return this.setSizeInternal(newWidth, newHeight, false);
		}
		
		protected function commitData():void
		{
			if(this._data)
			{
				this._label.text = this._data.text;
			}
			else
			{
				this._label.text = null;
			}
		}
		
		protected function layoutChildren():void
		{
			this._label.x = this._padding;
			this._label.y = this._padding;
			this._label.width = this.actualWidth - 2 * this._padding;
			this._label.height = this.actualHeight - 2 * this._padding;
			if(this._backgroundSkin)
			{
				this._backgroundSkin.width = this.actualWidth;
				this._backgroundSkin.height = this.actualHeight;
			}
			if(this._currentBackgroundSkin)
			{
				this._currentBackgroundSkin.width = this.actualWidth;
				this._currentBackgroundSkin.height = this.actualHeight;
			}
			
		}
		
		
		
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
		
		
		public function get downBackgroundSkin():DisplayObject
		{
			return this._downBackgroundSkin;
		}
		
		public function set downBackgroundSkin(value:DisplayObject):void
		{
			if(this._downBackgroundSkin == value)
			{
				return;
			}
			if(this._downBackgroundSkin)
			{
				this.removeChild(this._downBackgroundSkin, true);
			}
			this._downBackgroundSkin = value;
			if(this._downBackgroundSkin)
			{
				this.addChildAt(this._downBackgroundSkin, 0);
			}
			this.invalidate(INVALIDATION_FLAG_SKIN);
		}
		
		private function updateCurrentBackground():void
		{
			
			var newBackground:DisplayObject = this._backgroundSkin;
			if( this._currentState == STATE_DOWN )
			{
				newBackground = this._downBackgroundSkin;
			}
			// if you have additional states, you can add else ifs here.
			
			// check if the background is different than last time.
			if( this._currentBackgroundSkin == newBackground )
			{
				return;
			}
			
			if( this._currentBackgroundSkin )
			{
				// if we have an old background, make it invisible again.
				this._currentBackgroundSkin.visible = false;
			}
			this._currentBackgroundSkin = newBackground;
			if( this._currentBackgroundSkin )
			{
				// if we have a new background, make it visible.
				this._currentBackgroundSkin.visible = true;
			}
		}
	}
}