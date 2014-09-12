package uiscreens
{
	public class ScreenModel
	{
		public var x1:int = 0;
		public var y1:int = 0;
		public var x2:int = 0;
		public var y2:int = 0;
		public var nextScreen:String = "";
		public function ScreenModel(x1:int,y1:int,x2:int,y2:int,nextScreen:String)
		{
			this.x1 = x1;
			this.y1 = y1;
			this.x2 = x2;
			this.y2 = y2;
			this.nextScreen = nextScreen;
		}
		
	}
}