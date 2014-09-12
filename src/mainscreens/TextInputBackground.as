package mainscreens
{
	import starling.display.Image;
	import starling.display.Sprite;

	public class TextInputBackground extends Sprite
	{
		private var img:Image;
		
		public function TextInputBackground(_img:Image)
		{
			img = _img;
			addChild(img);
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set width(value:Number):void
		{
			trace("CHANGING WIDTH");
			// Do not change width dimensions
			//super.width = value;
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		override public function set height(value:Number):void
		{
			trace("CHANGING HEIGHT");
			// Do not change height dimensions
			//super.height = value;
		}
		
		public function color(value:uint):void {
			
			img.color = value;
			
		}
		
	}
}