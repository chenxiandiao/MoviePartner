package utils 
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EmbeddedAssets
	{
		
		[Embed(source="/../assets/images/home/bg.png")]	
		private static const HOME_BG_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/user-photo.png")]
		private static const USER_PHOTO_ICON_EMBEDDED:Class;

		[Embed(source="/../assets/images/home/movie-world.png")]
		private static const MOVIE_WORLD_ICON_EMBEDDED:Class;
	
		[Embed(source="/../assets/images/home/movie-create.png")]	
		private static const MOVIE_CREATE_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/movie-task.png")]	
		private static const MOVIE_TASK_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/movie-msg.png")]	
		private static const MOVIE_MSG_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/movie-team.png")]	
		private static const MOVIE_TEAM_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/movie-ar.png")]	
		private static const MOVIE_AR_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/movie-other.png")]	
		private static const MOVIE_OTHER_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/home/movie-world-content.png")]	
		private static const MOVIE_WORLD_CONTENT_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/textinput-bg.png")]	
		private static const TEXTINPUTGB_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/header.png")]	
		private static const REGISTOR_HEADER_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/username.png")]	
		private static const REGISTOR_USERNAME_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/password.png")]	
		private static const REGISTOR_PASSWORD_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/next.png")]	
		private static const REGISTOR_NEXT_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/role-add.png")]	
		private static const REGISTOR_ROLE_ADD_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/registor/role-choose.png")]	
		private static const REGISTOR_ROLE_CHOOSE_ICON_EMBEDDED:Class;
		
		
		[Embed(source="/../assets/images/login/header.png")]	
		private static const LOGIN_HEADER_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/login/content-bg.png")]
		private static const LOGIN_CONTENT_BG_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/login/login-area-bg.png")]
		private static const LOGIN_AREA_BG_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/login/input-bg.png")]
		private static const INPUT_BG_ICON_EMBEDDED:Class;
		
		[Embed(source="/../assets/images/login/login-btn.png")]
		private static const LOGIN_BTN_ICON_EMBEDDED:Class;
		
		public static var HOME_BG_ICON:Texture;
		
		public static var USER_PHOTO_ICON:Texture;

		public static var MOVIE_WORLD_ICON:Texture;
		
		public static var MOVIE_CREATE_ICON:Texture;
		
		public static var MOVIE_TASK_ICON:Texture;
		
		public static var MOVIE_MSG_ICON:Texture;
		
		public static var MOVIE_TEAM_ICON:Texture;
		
		public static var MOVIE_AR_ICON:Texture;
		
		public static var MOVIE_OTHER_ICON:Texture;
		
		public static var MOVIE_WORLD_CONTENT_ICON:Texture;
		
		public static var TEXTINPUT_BG_ICON:Texture;
		
		public static var REGISTOR_HEADER_ICON:Texture;
		
		public static var REGISTOR_USERNAME_ICON:Texture;
		
		public static var REGISTOR_PASSWORD_ICON:Texture;
		
		public static var REGISTOR_NEXT_ICON:Texture;

		public static var REGISTOR_ROLE_ADD_ICON:Texture;

		public static var REGISTOR_ROLE_CHOOSE_ICON:Texture;
		
		public static var LOGIN_HEADER_ICON:Texture;
		public static var LOGIN_CONTENT_BG_ICON:Texture;
		public static var LOGIN_AREA_BG_ICON:Texture;
		public static var INPUT_BG_ICON:Texture;
		public static var LOGIN_BTN_ICON:Texture;
//		[Embed(source="/../assets/images/metalworks.xml",mimeType="application/octet-stream")]
//		public static const metalworks_xml:Class;
		// Embed the Atlas Texture:
//		[Embed(source="/../assets/images/metalworks.png")]
//		public static const metalworks:Class;
		
		public static var atlas:TextureAtlas;
		
		public static function initialize():void
		{
			//we can't create these textures until Starling is ready
			HOME_BG_ICON = Texture.fromBitmap(new HOME_BG_ICON_EMBEDDED());
			USER_PHOTO_ICON = Texture.fromBitmap(new USER_PHOTO_ICON_EMBEDDED());
			MOVIE_WORLD_ICON = Texture.fromBitmap(new MOVIE_WORLD_ICON_EMBEDDED());
			MOVIE_CREATE_ICON =  Texture.fromBitmap(new MOVIE_CREATE_ICON_EMBEDDED());
			MOVIE_TASK_ICON =  Texture.fromBitmap(new MOVIE_TASK_ICON_EMBEDDED());
			MOVIE_MSG_ICON =  Texture.fromBitmap(new MOVIE_MSG_ICON_EMBEDDED());
			MOVIE_TEAM_ICON =  Texture.fromBitmap(new MOVIE_TEAM_ICON_EMBEDDED());
			MOVIE_AR_ICON =  Texture.fromBitmap(new MOVIE_AR_ICON_EMBEDDED());
			MOVIE_OTHER_ICON = Texture.fromBitmap(new MOVIE_OTHER_ICON_EMBEDDED());
			MOVIE_WORLD_CONTENT_ICON = Texture.fromBitmap(new MOVIE_WORLD_CONTENT_ICON_EMBEDDED());
			TEXTINPUT_BG_ICON = Texture.fromBitmap(new TEXTINPUTGB_ICON_EMBEDDED());
			
			LOGIN_HEADER_ICON = Texture.fromBitmap(new LOGIN_HEADER_ICON_EMBEDDED());
			LOGIN_CONTENT_BG_ICON = Texture.fromBitmap(new LOGIN_CONTENT_BG_ICON_EMBEDDED());
			LOGIN_AREA_BG_ICON = Texture.fromBitmap(new LOGIN_AREA_BG_ICON_EMBEDDED());
			INPUT_BG_ICON = Texture.fromBitmap(new INPUT_BG_ICON_EMBEDDED());
			LOGIN_BTN_ICON = Texture.fromBitmap(new LOGIN_BTN_ICON_EMBEDDED());
			
			
			REGISTOR_HEADER_ICON = Texture.fromBitmap(new REGISTOR_HEADER_ICON_EMBEDDED());
			REGISTOR_USERNAME_ICON = Texture.fromBitmap(new REGISTOR_USERNAME_ICON_EMBEDDED());
			REGISTOR_PASSWORD_ICON = Texture.fromBitmap(new REGISTOR_PASSWORD_ICON_EMBEDDED());
			
			REGISTOR_NEXT_ICON = Texture.fromBitmap(new REGISTOR_NEXT_ICON_EMBEDDED());
			
			REGISTOR_ROLE_ADD_ICON = Texture.fromBitmap(new REGISTOR_ROLE_ADD_ICON_EMBEDDED());
			
			REGISTOR_ROLE_CHOOSE_ICON = Texture.fromBitmap(new REGISTOR_ROLE_CHOOSE_ICON_EMBEDDED());
			trace("EmbededAssets texture load complete")
//			var texture:Texture = Texture.fromBitmap(new metalworks());
//			var xml:XML = XML(new metalworks_xml());
			
//			atlas = new TextureAtlas(texture, xml);
		}
	}
}
