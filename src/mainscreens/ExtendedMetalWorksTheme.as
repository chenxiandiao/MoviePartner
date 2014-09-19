package mainscreens
{
	import feathers.controls.Button;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.text.TextFormat;
	import flash.text.engine.ElementFormat;
	
	import render.LayoutScriptItemRenderer;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	
	import utils.EmbeddedAssets;

	
	
	public class ExtendedMetalWorksTheme extends MetalWorksMobileTheme
	{
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON:String = "my-custom-button";
		public static const USER_NAME_TEXTINPUT:String = "user-name-inputtext";
		public static const INPUT_BG:String = "input-bg";
		public static const TEXTAREA_BG:String = "textarea-bg";
		protected var timerListElementFormat:ElementFormat;
		protected var timerListDownElementFormat:ElementFormat;
		protected static const TIMER_LIST_TEXT_COLOR:uint = 0x000000;
		protected static const TIMER_LIST_DOWN_TEXT_COLOR:uint = 0xffffff;
		public function ExtendedMetalWorksTheme( root:DisplayObjectContainer = null, scaleToDPI:Boolean = true )
		{
			super( root, scaleToDPI );
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.timerListElementFormat = new ElementFormat(this.regularFontDescription, 28 * this.scale, TIMER_LIST_TEXT_COLOR);
			this.timerListDownElementFormat = new ElementFormat(this.regularFontDescription, 28 * this.scale, TIMER_LIST_DOWN_TEXT_COLOR);
			// set new initializers here
			
//			this.setInitializerForClass( Button, myCustomButtonInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON );
			this.setInitializerForClass(TextInput, myTextInputInitializer, USER_NAME_TEXTINPUT );
			this.setInitializerForClass(TextInput, myTextInputBgInitializer, INPUT_BG);
			this.setInitializerForClass(TextArea, myTextAreaBgInitializer,TEXTAREA_BG);
			this.setInitializerForClass(DefaultListItemRenderer, myItemRendererInitializer);
//			this.setInitializerForClass(LayoutScriptItemRenderer, myItemRendererInitializer);
		}
		
		protected function myItemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.myItemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = EmbeddedAssets.LIST_FOCUS_ICON;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: 88 * this.scale,
						height: 88 * this.scale,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.elementFormat = this.timerListElementFormat;
			renderer.downLabelProperties.elementFormat = this.timerListDownElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.timerListDownElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
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
		
		private function myTextAreaBgInitializer(textArea:TextArea):void
		{
			textArea.backgroundSkin = new Image(EmbeddedAssets.MOVIE_CREATE_CONCEPT_DESC_ICON);
			textArea.padding = 7;
			textArea.textEditorProperties.textFormat = new TextFormat( "楷体", 18, 0x333333);
		}
		
		
		
		private function myTextInputBgInitializer( input:TextInput):void
		{
			input.backgroundSkin = new Image( EmbeddedAssets.MOIVE_CREATE_CONCEPT_IDEA_ICON);
			input.padding = 7;
			input.textEditorProperties.fontFamily = "楷体";
			input.textEditorProperties.fontSize = 18;
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