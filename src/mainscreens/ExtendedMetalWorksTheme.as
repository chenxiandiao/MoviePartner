package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	
	import utils.EmbeddedAssets;

	
	
	public class ExtendedMetalWorksTheme extends MetalWorksMobileTheme
	{
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON:String = "my-custom-button";
		public static const USER_NAME_TEXTINPUT:String = "user-name-inputtext";
		public function ExtendedMetalWorksTheme( root:DisplayObjectContainer = null, scaleToDPI:Boolean = true )
		{
			super( root, scaleToDPI );
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			// set new initializers here
			
//			this.setInitializerForClass( Button, myCustomButtonInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON );
			this.setInitializerForClass(TextInput, myTextInputInitializer, USER_NAME_TEXTINPUT );
		}
		
		private function myCustomButtonInitializer( button:Button ):void
		{
//			button.defaultSkin = new Image(this.radioDisabledIconTexture);
			button.defaultSkin = new Image( EmbeddedAssets.TEXTINPUT_BG_ICON );
			
			
//			button.downSkin = new Image( downTexture );
//			button.hoverSkin = new Image( hoverTexture );
			button.defaultLabelProperties.elementFormat = this.darkUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			button.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
		}
		
		private function myTextInputInitializer( input:TextInput ):void
		{
//			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
//			skinSelector.defaultValue = EmbeddedAssets.TEXTINPUT_BG_ICON;
//			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
//			skinSelector.setValueForState(this.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
//			skinSelector.displayObjectProperties =
//				{
//						width: 264 * this.scale,
//						height: 60 * this.scale,
//						textureScale: this.scale
//				};
//			input.stateToSkinFunction = skinSelector.updateValue;
			input.backgroundSkin = new Image( EmbeddedAssets.INPUT_BG_ICON );
//			input.minWidth = input.minHeight = 60 * this.scale;
//			input.minTouchWidth = input.minTouchHeight = 88 * this.scale;
//			input.gap = 12 * this.scale;
//			input.paddingTop = 10;
//			input.paddingBottom = 10 * this.scale;
//			input.paddingLeft = input.paddingRight = 14 * this.scale;
			input.textEditorProperties.fontFamily = "微软雅黑";
			input.textEditorProperties.fontSize = 18;
//			input.textEditorProperties.multiline = false;
//			input.textEditorProperties.color = LIGHT_TEXT_COLOR;
			input.textEditorProperties.color = 0x0C0212;
			input.promptProperties.elementFormat = this.lightElementFormat;
		}
	}
}