package mainscreens
{
	import feathers.controls.Screen;

	public class RegistorScreen extends Screen
	{
		
		public function RegistorScreen()
		{
		}
		
		override protected function initialize():void
		{
			this.addChild(new RegistorStepOneScreen());
		}
	}
}