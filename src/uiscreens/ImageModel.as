package uiscreens
{
	import flash.display.Bitmap;
	
	import starling.textures.Texture;

	public class ImageModel
	{
	
		private var imageName:String = "";
		private var imageTexture:Texture = null;
		private var bitmap:Bitmap = null;
		public function ImageModel(imageName:String,bitmap:Bitmap)
		{
			this.imageName = imageName;
			this.bitmap = bitmap;
		}
		
		public function getImageName():String
		{
			return this.imageName;
		}
		
		public function getImageTexture():Texture
		{
			return this.imageTexture;
		}
		
		public function getBitmap():Bitmap
		{
			return this.bitmap;
		}
		
		
	}
}