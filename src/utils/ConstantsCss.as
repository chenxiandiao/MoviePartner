package utils
{
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	
	import flash.text.TextFormat;

	public class ConstantsCss
	{
		public function ConstantsCss()
		{
			
			
		}
		
		public static function headerLabelTextRenderer():ITextRenderer{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "微软雅黑";
			textFormat.size = 20;
			textFormat.color = 0x4B4B4B;
			textRenderer.textFormat  = textFormat;
			textRenderer.embedFonts = false;
			textRenderer.isHTML = false;
			return textRenderer;
		}
		
		public static function labelTextRenderer():ITextRenderer{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "微软雅黑";
			textFormat.size = 16;
			textFormat.color = 0x4B4B4B;
			textRenderer.textFormat  = textFormat;
			textRenderer.embedFonts = false;
			textRenderer.isHTML = false;
			return textRenderer;
		}
	}
}