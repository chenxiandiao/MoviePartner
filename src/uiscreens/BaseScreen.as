package uiscreens
{
	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.XmlReader;

	public class BaseScreen extends Screen
	{
		private var _xmlName:String = "";
		private var _pngName:String = "";
		public var _xmlReader:XmlReader = new XmlReader();
		private var screenArray:Array = [];	
		
		private var loader:Loader = new Loader();
		private var texture:Texture = null;
		private static var imageCollection:Array = []; 
		
		public function BaseScreen(xmlName:String,pngName:String)
		{
			this._xmlName = xmlName;
			this._pngName = pngName;
		}
		
		private function onComplete ( e:Event):void
		{
			// grab the loaded bitmap
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			
			// create a texture from the loaded bitmap
//			var texture:Texture = Texture.fromBitmap ( loadedBitmap );
			var imageModel:ImageModel = new ImageModel(e.target.url,loadedBitmap);
			imageCollection.push(imageModel);
			//删除父级页面

			if(texture!=null)
			{
				texture.dispose();
				texture = Texture.fromBitmap (loadedBitmap);
			}
			else
			{
				texture = Texture.fromBitmap (loadedBitmap);
			}
			if(this.numChildren!=0)
			{
				this.removeChildAt(0);
			}
			
			this.addChild(new Image(texture));
		}
		
		override protected function initialize():void
		{
			this._xmlReader.LoadXML(this._xmlName);
			initData();
			this.addEventListener(TouchEvent.TOUCH,onClickTriggered);
		}
		
		private function initData():void
		{
			var flag:Boolean = false;
			for(var i:int=0;i<imageCollection.length;i++)
			{
				if((ImageModel)(imageCollection[i]).getImageName()==this._pngName)
				{
					if(texture!=null)
					{
						texture.dispose();
						texture = Texture.fromBitmap ( (ImageModel)(imageCollection[i]).getBitmap() );
					}
					else
					{
						texture = Texture.fromBitmap ( (ImageModel)(imageCollection[i]).getBitmap() );
					}
					if(this.numChildren!=0)
					{
						this.removeChildAt(0);
					}
					this.addChild(new Image(texture));
					flag = true;
				}
			}
			if(!flag)
			{
				loader.load ( new URLRequest (this._pngName));
				loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, onComplete );
			}
			this._xmlReader.LoadXML(this._xmlName);
		}
		
		public function onClickTriggered(event:TouchEvent):void
		{
			
			var touch:Touch = event.getTouch( this);
			if( !touch )
			{
				// this should not happen.
				return;
			}
			if( touch.phase == TouchPhase.BEGAN )
			{
				screenArray = this._xmlReader.getScreenArray();
				var pointX:int = touch.globalX;
				var pointY:int = touch.globalY;
				trace("MovieCreate pointX:"+pointX+"pointY:"+pointY);
				for(var i:int = 0;i<screenArray.length;i++)
				{
					if(screenArray[i].x1<pointX&&screenArray[i].y1<pointY
						&&screenArray[i].x2>pointX&&screenArray[i].y2>pointY)
					{
						changeScreen(screenArray[i].nextScreen);
					}
				}
				
			}
			
		}
		
		public function changeScreen(screenName:String):void
		{
			this._xmlName = "app:/textures/"+screenName+".xml"
			this._pngName =	"app:/textures/"+screenName+".png";
			initData();
		}
	}
}