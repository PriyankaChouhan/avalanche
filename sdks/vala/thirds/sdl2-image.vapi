//FOR: SDL2.0 IMAGE - This is not official, to be futurely changed for the official binding
//Maintainer: PedroHLC

[CCode (cheader_filename = "SDL2/SDL_image.h")]
namespace SDLImage {
	//! Defines

	[CCode (cname = "IMG_InitFlags", cprefix = "IMG_INIT_")]
	public enum InitFlags {
	    JPG,
	    PNG,
	    TIF,
	    WEBP
	}

	//! General

	[CCode (cname = "IMG_Linked_Version")]
	public static unowned SDL.Version linked();

	[CCode (cname = "IMG_Init")]
	public static int init(int flags);

	[CCode (cname = "IMG_Quit")]
	public static void quit();

	//! Loading

	[CCode (cname = "IMG_Load")]
	public static SDL.Surface? load(string file);

	[CCode (cname = "IMG_Load_RW")]
	public static SDL.Surface? load_rw(SDL.RWops src, bool freesrc = false);

	[CCode (cname = "IMG_LoadTyped_RW")]
	public static SDL.Surface? load_rw_typed(SDL.RWops src, bool freesrc = false, string type);

	//[CCode (cname = "IMG_LoadTexture")]
	//public static SDL.Texture? load_texture(SDL.Renderer renderer, string file);

	//[CCode (cname = "IMG_LoadTexture_RW")]
	//public static SDL.Texture? load_texture_rw(SDL.Renderer renderer, SDL.RWops src, bool freesrc = false);

	//[CCode (cname = "IMG_LoadTextureTyped_RW")]
	//public static SDL.Texture? load_texture_rw_typed(SDL.Renderer renderer, SDL.RWops src, bool freesrc = false, string type);
	
	//
	
	[CCode (cname = "IMG_InvertAlpha")]
	public static int invert_alpha(int on);
	
	//

	[CCode (cname = "IMG_LoadCUR_RW")]
	public static SDL.Surface? load_cur(SDL.RWops src);

	[CCode (cname = "IMG_LoadICO_RW")]
	public static SDL.Surface? load_ico(SDL.RWops src);

	[CCode (cname = "IMG_LoadBMP_RW")]
	public static SDL.Surface? load_bmp(SDL.RWops src);

	[CCode (cname = "IMG_LoadPNM_RW")]
	public static SDL.Surface? load_pnm(SDL.RWops src);

	[CCode (cname = "IMG_LoadXPM_RW")]
	public static SDL.Surface? load_xpm(SDL.RWops src);

	[CCode (cname = "IMG_LoadXCF_RW")]
	public static SDL.Surface? load_xcf(SDL.RWops src);

	[CCode (cname = "IMG_LoadPCX_RW")]
	public static SDL.Surface? load_pcx(SDL.RWops src);

	[CCode (cname = "IMG_LoadGIF_RW")]
	public static SDL.Surface? load_gif(SDL.RWops src);

	[CCode (cname = "IMG_LoadJPG_RW")]
	public static SDL.Surface? load_jpg(SDL.RWops src);

	[CCode (cname = "IMG_LoadTIF_RW")]
	public static SDL.Surface? load_tif(SDL.RWops src);

	[CCode (cname = "IMG_LoadPNG_RW")]
	public static SDL.Surface? load_png(SDL.RWops src);

	[CCode (cname = "IMG_LoadTGA_RW")]
	public static SDL.Surface? load_tga(SDL.RWops src);

	[CCode (cname = "IMG_LoadLBM_RW")]
	public static SDL.Surface? load_lbm(SDL.RWops src);

	[CCode (cname = "IMG_LoadXV_RW")]
	public static SDL.Surface? load_xv(SDL.RWops src);

	[CCode (cname = "IMG_LoadWEBP_RW")]
	public static SDL.Surface? load_webp(SDL.RWops src);

	[CCode (cname = "IMG_ReadXPMFromArray")]
	public static SDL.Surface? read_xpm(string[] xpmdata);

	//!Info

	[CCode (cname = "IMG_isCUR")]
	public static bool is_cur(SDL.RWops src);

	[CCode (cname = "IMG_isICO")]
	public static bool is_ico(SDL.RWops src);

	[CCode (cname = "IMG_isBMP")]
	public static bool is_bmp(SDL.RWops src);

	[CCode (cname = "IMG_isPNM")]
	public static bool is_pnm(SDL.RWops src);

	[CCode (cname = "IMG_isXPM")]
	public static bool is_xpm(SDL.RWops src);

	[CCode (cname = "IMG_isXCF")]
	public static bool is_xcf(SDL.RWops src);

	[CCode (cname = "IMG_isPCX")]
	public static bool is_pcx(SDL.RWops src);

	[CCode (cname = "IMG_isGIF")]
	public static bool is_gif(SDL.RWops src);

	[CCode (cname = "IMG_isJPG")]
	public static bool is_jpg(SDL.RWops src);

	[CCode (cname = "IMG_isTIF")]
	public static bool is_tif(SDL.RWops src);

	[CCode (cname = "IMG_isPNG")]
	public static bool is_png(SDL.RWops src);

	[CCode (cname = "IMG_isLBM")]
	public static bool is_lbm(SDL.RWops src);

	[CCode (cname = "IMG_isXV")]
	public static bool is_xv(SDL.RWops src);

	[CCode (cname = "IMG_isWEBP")]
	public static bool is_webp(SDL.RWops src);
} // SDLImage
