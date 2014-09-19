package mainscreens
{
	import feathers.controls.Screen;
	
	import utils.ConstantsUtil;

	public class MovieCreateScreen extends Screen
	{
		
		public function MovieCreateScreen()
		{
		}
		
		override protected function initialize():void
		{
			trace("MovieCreateScreen initialize");
			PageIndex.movieCreateIndex = "ConceptTalkScreen";
			if (PageIndex.movieCreateIndex == ""||PageIndex.movieCreateIndex == "ConceptCreateScreen")
			{
				this.addChild(new ConceptCreateScreen());
			}
			else if(PageIndex.movieCreateIndex == "ConceptTalkScreen")
			{
				this.addChild(new ConceptTalkScreen());
			}
			
		}
	}
}