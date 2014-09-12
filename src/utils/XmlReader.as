package utils
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import uiscreens.ScreenModel;

	public class XmlReader
	{
		private var loader:URLLoader = new URLLoader();
		private var myxml:XML;
		private var screenArray:Array = [];
		public function XmlReader()
		{
		}
		
		public function LoadXML(url:String):void {  
			//设置变量requestt为URLLLoader数据类型并创建实例  
			var request:URLRequest = new URLRequest(url);  
			//实例loader用方法load读取变量URLRequest实例,(读取路径)  
			loader.load(request);  
			//实例loader注册侦听(事件为Event.COMPLETE,调用onComplete函数处理)  
			loader.addEventListener(flash.events.Event.COMPLETE, onComplete);  
		} 
		
		public function onComplete(event:flash.events.Event):void {  
			//xml数据类型变量myxml创建实例,读取xml的数据
			screenArray = [];
			myxml = new XML(loader.data);  
			//输出myxml的数据
//			trace(myxml.attribute("imagePath"));
			var length:int = myxml.children().length();
			for(var i:int = 0;i<length;i++)
			{
				var x1:int = myxml.children()[i].attribute("x1");
				var y1:int = myxml.children()[i].attribute("y1");
				var x2:int = myxml.children()[i].attribute("x2");
				var y2:int = myxml.children()[i].attribute("y2");
				var nextScreen:String = myxml.children()[i].attribute("nextScreen");
//				trace(x1+" "+y1+" "+x2+" "+y2+" "+nextScreen+" "+showType);
				var screenModel:ScreenModel = new ScreenModel(x1,y1,x2,y2,nextScreen);
				screenArray.push(screenModel);
			}
		}  
		
		public function getScreenArray():Array
		{
			return screenArray;
		}
	}
}