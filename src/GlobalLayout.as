package
{
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;

	public class GlobalLayout
	{
		public function GlobalLayout()
		{
			
		}
		
		public static function hLayoutCenter():HorizontalLayout
		{
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			horizontalLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			return horizontalLayout;
		}
		
		public static function vLayoutCeneter():VerticalLayout
		{
			var verticalLayout:VerticalLayout = new VerticalLayout();
			return verticalLayout;
		}
		
	}
}