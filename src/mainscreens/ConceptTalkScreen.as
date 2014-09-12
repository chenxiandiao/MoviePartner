package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import flash.geom.Rectangle;
	import flash.text.StageText;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	import utils.EmbeddedAssets;

	public class ConceptTalkScreen extends Screen
	{
		public function ConceptTalkScreen()
		{
		}
		override protected function initialize():void
		{
			trace("ConceptTalkScreen initialize");
			trace(this.name);
			PageIndex.movieCreateIndex = "ConceptTalkScreen";
//			var btn:Button = new Button();
//			btn.label = "concept talk";
//			this.addChild(btn);
			
			var input:TextInput = new TextInput();

			input.nameList.add(ExtendedMetalWorksTheme.USER_NAME_TEXTINPUT);
//			input.width = 261;
//			input.height = 90;
 			input.prompt = "请输入手机号或邮箱";
//			var bg:TextInputBackground =  new TextInputBackground(new Image(EmbeddedAssets.TEXTINPUT_BG_ICON));
//			input.backgroundSkin = bg;
//			input.backgroundSkin = new Image(EmbeddedAssets.TEXTINPUT_BG_ICON);
//			input.defaultIcon = new Image(EmbeddedAssets.TEXTINPUT_BG_ICON);
//			input.backgroundSkin = AcheckDisabledIconTexture;
			
//			var quad:Quad = new Quad(200, 50, 0xff00ff);
//			quad.x = 100;
//			quad.y = 100;
//			this.addChild(quad);
//			
//			var stageText:StageText = new StageText();
//			stageText.fontSize = 36;
//			stageText.text = "Hello";
//			stageText.viewPort = new Rectangle(100, 100, 200, 50);
//			stageText.stage = Starling.current.nativeStage;
			this.addChild( input );
//			this.addChild(stageText);
		}
	}
}