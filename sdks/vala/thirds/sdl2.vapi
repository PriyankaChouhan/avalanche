//FOR: SDL2.0 - This is not official, to be futurely changed for the official binding
//Maintainer: PedroHLC
[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL.h")]
namespace SDL {
	///
	/// Initialization
	///
	[Flags, CCode (cname="int", cprefix="SDL_INIT_")]
	public enum InitFlag {
		TIMER, AUDIO, VIDEO, JOYSTICK, HAPTIC,
		GAMECONTROLLER, NOPARACHUTE, EVERYTHING
	}// InitFlag

	[CCode (cname="SDL_Init")]
	public static int init(uint32 flags = SDL.InitFlag.EVERYTHING);

	[CCode (cname="SDL_InitSubSystem")]
	public static int init_subsystem(uint32 flags);

	[CCode (cname="SDL_WasInit")]
	public static uint32 get_initialized(uint32 flags);

	[CCode (cname="SDL_Quit")]
	public static void quit();

	[CCode (cname="SDL_QuitSubSystem")]
	public static void quit_subsystem(uint32 flags);

	[CCode (type_id="SDL_version", cheader_filename="SDL2/SDL_version.h", cname="SDL_version")]
	public class Version {
		public uint8 major;
		public uint8 minor;
		public uint8 patch;

		[CCode (cname="SDL_GetVersion")]
		public static unowned Version get_version();
		
		[CCode (cname="SDL_GetRevision")]
		public static unowned string get_revision();
		
		[CCode (cname="SDL_GetRevisionNumber")]
		public static int get_revision_number();
	}// Version


	///
	/// Error
	///
	[CCode (cname="SDL_errorcode", cprefix="SDL_")]
	public enum Error {
		ENOMEM, EFREAD, EFWRITE, EFSEEK, 
		UNSUPPORTED, LASTERROR
	}// Error

	[CCode (cname="SDL_SetError")]
	public static int set_error(string format, ...);

	[CCode (cname="SDL_GetError")]
	public static unowned string get_error();

	[CCode (cname="SDL_ClearError")]
	public static void clear_error();

	[CCode (cname="SDL_Error")]
	public static void error(Error code);

	
	///
	/// Video requires
	///
	public enum Opacity {
		OPAQUE=255,
		TRANSPARENT=0
	}// Opacity
	
	[CCode (cprefix="SDL_PIXELTYPE_")]
	public enum PixelType {
		UNKNOWN,
		INDEX1, INDEX4, INDEX8, PACKED8, PACKED16, PACKED32,
		ARRAYU8, ARRAYU16, ARRAYU32, ARRAYF16, ARRAYF32
	}// PixelType
	
	[CCode (cprefix="SDL_BITMAPORDER")]
	public enum BitmapOrder {
		_NONE,  _4321,  _1234
	}// BitmapOrder
	
	[CCode (cprefix="SDL_PACKEDORDER_")]
	public enum PackedOrder {
		NONE, XRGB, RGBX, ARGB, RGBA,
		XBGR, BGRX, ABGR, BGRA
	}// PackedOrder
	
	[CCode (cprefix="SDL_ARRAYORDER_")]
	public enum ArrayOrder {
		NONE, RGB, RGBA,
		ARGB, BGR, BGRA, ABGR
	}// ArrayOrder
	
	[CCode (cprefix="SDL_PACKEDLAYOUT")]
	public enum PackedLayout {
		_NONE, _332, _4444, _1555, _5551,
		_565, _8888, _2101010, _1010102
	}// PackedLayout
	
	[CCode (cname="SDL_BlendMode", cprefix="SDL_BLENDMODE_")]
	public enum BlendMode {
		NONE, BLEND, ADD, MOD
	}// BlendMode
	
	[CCode (cname="SDL_Point", cheader_filename="SDL2/SDL_rect.h")]
	[SimpleType]
	public struct Point {
		public int x;
		public int y;
	}// Point
	
	[CCode (cname="SDL_BlitMap")]
	[SimpleType]
	public struct BlitMap {
		//TODO
	}// BlitMap

	[CCode (type_id="SDL_Rect", cheader_filename="SDL2/SDL_rect.h", cname="SDL_Rect")]
	[Compact]
	public class Rect {
		public int x;
		public int y;
		public int w;
		public int h;

		public bool is_empty(){
			return(this.w<=0 || this.h<=0);
		}

		public bool is_equal(SDL.Rect other_rect){
			return(this == other_rect ||
			       (this.x==other_rect.x &&
			        this.y==other_rect.y &&
			        this.w==other_rect.w &&
			        this.h==other_rect.h)
			      );
		}

		[CCode (cname="SDL_HasIntersection")]
		public bool is_intersecting(SDL.Rect B);

		[CCode (cname="SDL_IntersectRect")]
		public bool intersection_rect(SDL.Rect B, out SDL.Rect result);

		[CCode (cname="SDL_UnionRect")]
		public void union_rect(SDL.Rect B, out SDL.Rect result);

		[CCode (cname="SDL_EnclosePoints")]
		public bool eclose_points(int count, SDL.Rect clip, out SDL.Rect result);

		[CCode (cname="SDL_IntersectRectAndLine")]
		public bool intersection_rectANDline(out int X1, out int Y1, out int X2, out int Y2);
	}// Rect
	
	[CCode (cname="SDL_Color", cheader_filename="SDL2/SDL_pixels.h")]
	public struct Color {
		public uint8 r;
		public uint8 g;
		public uint8 b;
		public uint8 a;
	}
	
	[CCode (type_id="SDL_Palette", cname="SDL_Palette", cheader_filename="SDL2/SDL_pixels.h", cprefix="SDL_", free_function="SDL_FreePalette")]
	public class Palette {
		public int ncolors;
		public SDL.Color[] colors;
		public uint32 version;
		public int refcount;

		[CCode (cname="SDL_AllocPalette")]
		public Palette(int colors_num);

		[CCode (cname="SDL_SetPaletteColors")]
		public int set_colors(SDL.Color[] colors, int first_color, int colors_num);
	}
	
	[CCode (type_id="SDL_PixelFormat", cname="SDL_PixelFormat", cheader_filename="SDL2/SDL_pixels.h", cprefix="SDL_", free_function="SDL_FreeFormat")]
	public class PixelFormat {
		public uint32 format;
		public SDL.Palette palette;
		public uint8 BitsPerPixel;
		public uint8 BytesPerPixel;
		public uint8 padding[2];
		public uint32 Rmask;
		public uint32 Gmask;
		public uint32 Bmask;
		public uint32 Amask;
		public uint8 Rloss;
		public uint8 Gloss;
		public uint8 Bloss;
		public uint8 Aloss;
		public uint8 Rshift;
		public uint8 Gshift;
		public uint8 Bshift;
		public uint8 Ashift;

		public int refcount;
		public SDL.PixelFormat next;

		[CCode (cname="SDL_AllocFormat")]
		public PixelFormat(uint32 pixel_format);

		[CCode (cname="SDL_SetPixelFormatPalette")]
		public int set_palette(SDL.Palette palette);

		[CCode (cname="SDL_MapRGB")]
		public uint32 map_rgb(uint8 r, uint8 g, uint8 b);

		[CCode (cname="SDL_MapRGBA")]
		public uint32 map_rgba(uint8 r, uint8 g, uint8 b, uint8 a);

		[CCode (cname="SDL_GetRGB", instance_pos=1.2)]
		public void get_rgb(uint32 pixel, ref uint8 r, ref uint8 g, ref uint8 b);

		[CCode (cname="SDL_GetRGBA", instance_pos=1.2)]
		public void get_rgba(uint32 pixel, ref uint8 r, ref uint8 g, ref uint8 b, ref uint8 a);
		
		[CCode (cname="SDL_CalculateGammaRamp")]
		public static void calc_gamma_ramp(float gamma, out uint16 ramp);
		
		[CCode (cname="SDL_GetPixelFormatName")]
		public static string get_pixelformatname(uint32 format);
		
		[CCode (cname="SDL_PixelFormatEnumToMasks")]
		public static bool enum_tomasks(uint32 format,
			int[] bpp,	uint32[] Rmask, uint32[] Gmask, uint32[] Bmask, uint32[] Amask);
		
		[CCode (cname="SDL_MasksToPixelFormatEnum")]
		public static uint32 masks_toenum(
			int[] bpp,	uint32[] Rmask, uint32[] Gmask, uint32[] Bmask, uint32[] Amask);
	}// PixelFormat

	[CCode (cname="SDL_blit", cheader_filename="SDL2/SDL_surface.h")]
	public delegate int blit (SDL.Surface *src, SDL.Rect *srcrect,
	                          SDL.Surface *dst, SDL.Rect *dstrect);

	[CCode (type_id="SDL_Surface", cname="SDL_Surface", free_function="SDL_FreeSurface", cheader_filename="SDL2/SDL_surface.h",unref_function="")]
	public class Surface {
		public uint32 flags;
		public SDL.PixelFormat format;
		public int w;
		public int h;
		public int pitch;
		public void *pixels;
		public void *userdata;
		public int locked;
		public void *lock_data;
		public SDL.Rect clip_rect;
		public SDL.BlitMap map;
		public int refcount;

		[CCode (cname="SDL_CreateRGBSurface")]
		public Surface.rgb(uint32 flags, int width, int height, int depth,
					uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask);

		[CCode (cname="SDL_CreateRGBSurfaceFrom")]
		public Surface.from_rgb(void* pixels, int width, int height, int depth, 
			int pitch, uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask);

		[CCode (cname="SDL_LoadBMP_RW")]
		public Surface.from_bmp_rw(SDL.RWops src, int freesrc=0);

		public Surface.from_bmp(string file){
			Surface.from_bmp_rw(new SDL.RWops.from_file(file, "rb"), 1);
		}

		[CCode (cname="SDL_SetSurfacePalette")]
		public int set_palette (SDL.Palette palette);

		[CCode (cname="SDL_LockSurface")]
		public int do_lock();

		[CCode (cname="SDL_UnlockSurface")]
		public void unlock();

		[CCode (cname="SDL_SaveBMP_RW")]
		public int save_bmp_rw(RWops dst, int freedst=0);

		public int save_bmp(string file){
			return save_bmp_rw(new SDL.RWops.from_file(file, "wb"), 1);
		}

		[CCode (cname="SDL_SetSurfaceRLE")]
		public int set_rle(int flag);

		[CCode (cname="SDL_SetColorKey")]
		public int set_colorkey(int flag, uint32 key);

		[CCode (cname="SDL_GetColorKey")]
		public int get_colorkey(out uint32 key);

		[CCode (cname="SDL_SetSurfaceColorMod")]
		public int set_colormod(uint8 r, uint8 g, uint8 b);

		[CCode (cname="SDL_GetSurfaceColorMod")]
		public int get_colormod(out uint8 r, out int8 g, out uint8 b);

		[CCode (cname="SDL_SetSurfaceAlphaMod")]
		public int set_alphamod(uint8 alpha);

		[CCode (cname="SDL_GetSurfaceAlphaMod")]
		public int get_alphamod(out uint8 alpha);

		[CCode (cname="SDL_SetSurfaceBlendMode")]
		public int set_blendmode(SDL.BlendMode blend_mode);

		[CCode (cname="SDL_GetSurfaceBlendMode")]
		public int get_blendmode(out SDL.BlendMode blend_mode);

		[CCode (cname="SDL_SetClipRect")]
		public bool set_cliprect(SDL.Rect? rect);

		[CCode (cname="SDL_GetClipRect")]
		public int get_cliprect(out SDL.Rect rect);

		[CCode (cname="SDL_ConvertSurface")]
		public Surface? convert(SDL.PixelFormat? fmt, uint32 flags);

		[CCode (cname="SDL_ConvertSurfaceFormat")]
		public Surface? convert_format(uint32 pixel_fmt, uint32 flags);

		[CCode (cname="SDL_ConvertPixels")]
		public static int convert_pixels(int width, int height,
                                              uint32 src_format,
                                              void *src, int src_pitch,
                                              uint32 dst_format,
                                              void * dst, int dst_pitch);
		
		[CCode (cname="SDL_FillRect")]
		public int fill_rect(SDL.Rect? rect, uint32 color);
		
		[CCode (cname="SDL_FillRects")]
		public int fill_rects(SDL.Rect[] rects, int count, uint32 color);

		[CCode (cname="SDL_UpperBlit")]
		public int blit(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_UpperBlit")]
		public int upperblit(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_LowerBlit")]
		public int lowerblit(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_UpperBlitScaled")]
		public int blit_scaled(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_UpperBlitScaled")]
		public int upperblit_scaled(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_LowerBlitScaled")]
		public int lowerblit_scaled(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_SoftStretch")]
		public int softstretch(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);
	} //Surface


	///
	/// Video
	///
	
	[CCode (cname="SDL_DisplayMode", cheader_filename="SDL2/SDL_video.h")]
	public struct DisplayMode {
		public uint32 format;
		public int w;
		public int h;
		public int refresh_rate;
		public void *driverdata; //Plese, initialize as NULL
	}// DisplayMode

	[Flags, CCode (cname="SDL_WindowFlags", cprefix="SDL_WINDOW_", cheader_filename="SDL2/SDL_video.h")]
	public enum WindowFlags {
		FULLSCREEN, OPENGL, SHOWN, HIDDEN, BORDERLESS, RESIZABLE,
		MINIMIZED, MAXIMIZED, INPUT_GRABBED, INPUT_FOCUS, MOUSE_FOCUS,
		FULLSCREEN_DESKTOP, FOREIGN
	}// WindowFlags

	[Flags, CCode (cname="SDL_WindowEventID", cprefix="SDL_WINDOWEVENT_", cheader_filename="SDL2/SDL_video.h")]
	public enum WindowEventID {
		NONE, SHOWN, HIDDEN, EXPOSED, MOVED, RESIZED,
		SIZE_CHANGED, MINIMIZED, MAXIMIZED, RESTORED,
		ENTER, LEAVE, FOCUS_GAINED, FOCUS_LOST, CLOSE
	}// WindowEventID

	
	[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class Video {
		[CCode (cname="SDL_GetNumVideoDrivers")]
		public static int num_drivers();
		
		[CCode (cname="SDL_GetVideoDriver")]
		public static unowned string? get_driver(int driver_index);
		
		[CCode (cname="SDL_VideoInit")]
		public static int init(string driver_name);
		
		[CCode (cname="SDL_VideoQuit")]
		public static void quit();
		
		[CCode (cname="SDL_GetCurrentVideoDriver")]
		public static unowned string? get_current_driver();
		
		[CCode (cname="SDL_GetNumVideoDisplays")]
		public static int num_displays();
		
		[CCode (cname="SDL_IsScreenSaverEnabled")]
		public static bool is_screensaver_enabled();
		
		[CCode (cname="SDL_EnableScreenSaver")]
		public static void enable_screensaver();
		
		[CCode (cname="SDL_DisableScreenSaver")]
		public static void disable_screensaver();
	}// Video
	
	[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class Dysplay { //Considering to put it out class Video
		[CCode (cname="SDL_GetDisplayName")]
		public static unowned string? get_name(int index);
		
		[CCode (cname="SDL_GetDisplayBounds")]
		public static int get_bounds(int index, out SDL.Rect rect);
		
		[CCode (cname="SDL_GetNumDisplayModes")]
		public static int num_modes(int index);
		
		[CCode (cname="SDL_GetDisplayMode")]
		public static int get_mode(int dysplay_index, int mode_index, out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetDesktopDisplayMode")]
		public static int get_desktop_mode(int index, out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetCurrentDisplayMode")]
		public static int get_current_mode(int index, out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetClosestDisplayMode")]
		public static SDL.DisplayMode get_closest_mode(int index, SDL.DisplayMode mode, out SDL.DisplayMode closest);
	}// Dysplay
	
	[CCode (cprefix="SDL_", cname = "SDL_Window", destroy_function = "SDL_DestroyWindow", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class Window {
		[CCode (cname="SDL_WINDOWPOS_UNDEFINED_MASK")]
		public static const uint8 POS_UNDEFINED;
		
		[CCode (cname="SDL_WINDOWPOS_CENTERED_MASK")]
		public static const uint8 POS_CENTERED;
		
		[CCode (cname="SDL_CreateWindow")]
		public Window(string title, int x, int y, int w, int h, uint32 flags);
		
		// Param data is a "pointer to driver-dependent window creation data"
		[CCode (cname="SDL_CreateWindowFrom")]
		public Window.from_native(void *data);
		
		[CCode (cname="SDL_GetWindowFromID")]
		public Window.from_id(uint32 id);
		
		[CCode (cname="SDL_GetWindowDisplayIndex")]
		public int get_display();
		
		[CCode (cname="SDL_SetWindowDisplayMode")]
		public int set_display_mode(SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetWindowDisplayMode")]
		public int get_display_mode(out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetWindowPixelFormat")]
		public uint32 get_pixelformat();
		
		[CCode (cname="SDL_GetWindowID")]
		public uint32 get_id();
		
		[CCode (cname="SDL_GetWindowFlags")]
		public uint32 get_flags();
		
		[CCode (cname="SDL_SetWindowTitle")]
		public void set_title(string title);
		
		[CCode (cname="SDL_GetWindowTitle")]
		public string get_title();
		
		[CCode (cname="SDL_SetWindowIcon")]
		public void set_icon(SDL.Surface icon);
		
		[CCode (cname="SDL_SetWindowData")]
		public void *set_data(string name, void *usrdata);
		
		[CCode (cname="SDL_GetWindowData")]
		public void *get_data(string name);
		
		[CCode (cname="SDL_SetWindowPosition")]
		public void set_position(int x, int y);
		
		[CCode (cname="SDL_GetWindowPosition")]
		public void get_position(out int x, out int y); //TODO: create a beutilful method
		
		[CCode (cname="SDL_SetWindowSize")]
		public void set_size(int w, int h);
		
		[CCode (cname="SDL_GetWindowSize")]
		public void get_size(out int w, out int x); //TODO: create a beutilful method
		
		[CCode (cname="SDL_SetWindowMinimumSize")]
		public void set_minsize(int w, int h);
		
		[CCode (cname="SDL_GetWindowMinimumSize")]
		public void get_minsize(out int w, out int x); //TODO: create a beutilful method
		
		[CCode (cname="SDL_SetWindowMaximumSize")]
		public void set_maxsize(int w, int h);
		
		[CCode (cname="SDL_GetWindowMaximumSize")]
		public void get_maxsize(out int w, out int x); //TODO: create a beutilful method
		
		[CCode (cname="SDL_SetWindowBordered")]
		public void set_bordered(bool bordered);
		
		[CCode (cname="SDL_ShowWindow")]
		public void show();
		
		[CCode (cname="SDL_HideWindow")]
		public void hide();
		
		[CCode (cname="SDL_RaiseWindow")]
		public void raise();
		
		[CCode (cname="SDL_MaximizeWindow")]
		public void maximize();
		
		[CCode (cname="SDL_MinimizeWindow")]
		public void minimize();
		
		[CCode (cname="SDL_RestoreWindow")]
		public void restore();
		
		[CCode (cname="SDL_SetWindowFullscreen")]
		public int set_fullscreen(uint32 flags);
		
		[CCode (cname="SDL_GetWindowSurface")]
		public SDL.Surface get_surface();
		
		[CCode (cname="SDL_UpdateWindowSurface")]
		public int update_surface();
		
		[CCode (cname="SDL_UpdateWindowSurfaceRects")]
		public int update_surface_rects(SDL.Rect[] rects, int rects_num);
		
		[CCode (cname="SDL_SetWindowGrab")]
		public void set_grab(bool grabbed);
		
		[CCode (cname="SDL_GetWindowGrab")]
		public bool get_grab();
		
		[CCode (cname="SDL_SetWindowBrightness")]
		public int set_brightness(float brightness);
		
		[CCode (cname="SDL_GetWindowBrightness")]
		public float get_brightness();
		
		[CCode (cname="SDL_SetWindowGammaRamp")]
		public int set_gammaramp(uint16[]? red, uint16[]? green, uint16[]? blue);
		
		[CCode (cname="SDL_GetWindowGammaRamp")]
		public int get_gammaramp(out uint16[]? red,out uint16[]? green, out uint16[]? blue);
		
		[CCode (cname="SDL_DestroyWindow")]
		public void destroy();
	}//Window
	
	///
	/// OpenGL
	///
	[CCode (cname="SDL_GLattr", cprefix="SDL_GL_", cheader_filename="SDL2/SDL_video.h")]
	public enum GLattr {
		RED_SIZE, GREEN_SIZE, BLUE_SIZE, ALPHA_SIZE, 
		BUFFER_SIZE, DOUBLEBUFFER, DEPTH_SIZE, STENCIL_SIZE, 
		ACCUM_RED_SIZE, ACCUM_GREEN_SIZE, ACCUM_BLUE_SIZE, 
		ACCUM_ALPHA_SIZE, STEREO, MULTISAMPLEBUFFERS, 
		MULTISAMPLESAMPLES, ACCELERATED_VISUAL, RETAINED_BACKING,
		CONTEXT_MAJOR_VERSION, CONTEXT_MINOR_VERSION,
		CONTEXT_EGL, CONTEXT_FLAGS, CONTEXT_PROFILE_MASK,
		SHARE_WITH_CURRENT_CONTEXT
	}// GLattr

	[CCode (type_id="SDL_GLContext", cname="SDL_GLContext", cheader_filename="SDL2/SDL_video.h")]
	public class GLContext{
	}// GLContext

	[CCode (cprefix="SDL_GL_", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class GL {
		[CCode (cname="SDL_GL_LoadLibrary")]
		public static int load_library(string path);

		[CCode (cname="SDL_GL_GetProcAddress")]
		public static void* get_proc_address(string proc);
		
		[CCode (cname="SDL_GL_UnloadLibrary")]
		public static void unload_lybrary();
		
		[CCode (cname="SDL_GL_ExtensionSupported")]
		public static bool is_extension_supported(string extension);

		[CCode (cname="SDL_GL_SetAttribute")]
		public static int set_attribute(SDL.GLattr attr, int val);

		[CCode (cname="SDL_GL_GetAttribute")]
		public static int get_attribute(SDL.GLattr attr, ref int val);

		[CCode (cname="SDL_GL_CreateContext")]
		public static SDL.GLContext create_context(SDL.Window window);

		[CCode (cname="SDL_GL_MakeCurrent")]
		public static int make_current(SDL.Window window, SDL.GLContext context);

		[CCode (cname="SDL_GL_SetSwapInterval")]
		public static int set_swapinterval(int interval);

		[CCode (cname="SDL_GL_GetSwapInterval")]
		public static int get_swapinterval();

		[CCode (cname="SDL_GL_SwapWindow")]
		public static void swap_window(SDL.Window window);

		[CCode (cname="SDL_GL_DeleteContext")]
		public static void delete_context(SDL.GLContext context);
	}// GL
	
	///
	/// RWops
	///
	[CCode (cname="SDL_RWops", free_function="SDL_FreeRW", cheader_filename="SDL2/SDL_rwops.h")]
	[Compact]
	public class RWops {
		[CCode (cname="SDL_RWFromFile")]
		public RWops.from_file(string file, string mode);

		[CCode (cname="SDL_RWFromMem")]
		public RWops.from_mem(void* mem, int size);
	}// RWops
	
	///
	/// Events
	///
	[CCode (cname="SDL_EventType", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventType {
		QUIT, WINDOWEVENT, SYSWMEVENT, KEYDOWN, KEYUP, TEXTEDITING,
		TEXTINPUT, MOUSEMOTION, MOUSEBUTTONUP, MOUSEBUTTONDOWN, 
		MOUSEWHEEL, JOYAXISMOTION, JOYBALLMOTION, JOYHATMOTION, JOYBUTTONUP, 
		JOYBUTTONDOWN, JOYDEVICEADDED, JOYDEVICEREMOVED, CONTROLLERAXISMOTION, 
		CONTROLLERBUTTONDOWN, CONTROLLERBUTTONUP, CONTROLLERDEVICEADDED,
		CONTROLLERDEVICEREMOVED, CONTROLLERDEVICEREMAPPED, FINGERDOWN,
		FINGERUP, FINGERMOTION, DOLLARGESTURE, DOLLARRECORD, MULTIGESTURE,
		CLIPBOARDUPDATE, DROPFILE, USEREVENT
	}// EventType
	
	[CCode (cname="SDL_GenericEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct GenericEvent {
		SDL.EventType type;
		uint32 timestamp;
	}// GenericEvent
	
	[CCode (cname="SDL_WindowEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct WindowEvent : GenericEvent {
		uint32 windowID;
		uint8 event;
		uint8 padding1;
		uint8 padding2;
		uint8 padding3;
		int32 data1;
		int32 data2;
	}// WindowEvent
	
	[CCode (cname="SDL_KeyboardEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct KeyboardEvent : GenericEvent {
		uint32 windowID;
		uint8 state;
		uint8 repeat;
		uint8 padding2;
		uint8 padding3;
		SDL.Key keysym;
	}// KeyboardEvent
	
	[CCode (cname="SDL_TextEditingEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct TextEditingEvent : GenericEvent {
		[CCode (cname="SDL_TEXTEDITINGEVENT_TEXT_SIZE")]
		public static const uint8 TEXT_SIZE;
		
		uint32 windowID;
		char text[]; //Or it would be better a string?
		int32 start;
		int32 length;
	}// TextEditingEvent
	
	[CCode (cname="SDL_TextInputEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct TextInputEvent : GenericEvent {
		[CCode (cname="SDL_TEXTINPUTEVENT_TEXT_SIZE")]
		public static const uint8 TEXT_SIZE;
		
		uint32 windowID;
		char text[]; //Or it would be better a string?
	}// TextInputEvent
	
	[CCode (cname="SDL_MouseMotionEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MouseMotionEvent : GenericEvent {
		uint32 windowID;
		uint32 which;
		uint8 state;
		uint8 padding1;
		uint8 padding2;
		uint8 padding3;
		int32 x;
		int32 y;
		int32 xrel;
		int32 yrel;
	}// MouseMotionEvent
	
	[CCode (cname="SDL_MouseButtonEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MouseButtonEvent : GenericEvent {
		uint32 windowID;
		uint32 which;
		uint8 button;
		uint8 state;
		uint8 padding1;
		uint8 padding2;
		int32 x;
		int32 y;
	}// MouseButtonEvent
	
	[CCode (cname="SDL_MouseWheelEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MouseWheelEvent : GenericEvent {
		uint32 windowID;
		uint32 which;
		int32 x;
		int32 y;
	}// MouseWheelEvent
	
	[CCode (cname="SDL_JoyAxisEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyAxisEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
		uint8 axis;
		uint8 padding1;
		uint8 padding2;
		uint8 padding3;
		int16 value;
		uint16 padding4;
	}// JoyAxisEvent
	
	[CCode (cname="SDL_JoyBallEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyBallEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
		uint8 ball;
		uint8 padding1;
		uint8 padding2;
		uint8 padding3;
		int16 xrel;
		int16 yrel;
	}// JoyBallEvent
	
	[CCode (cname="Uint8", cprefix="SDL_HAT_", cheader_filename="SDL2/SDL_events.h")]
	public enum HatValue {
		LEFTU, UP, RIGHTUP,
		LEFT, CENTERED, RIGHT,
		LEFTDOWN, DOWN, RIGHTDOWN
	}
	
	[CCode (cname="SDL_JoyHatEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyHatEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
		uint8 hat;
		SDL.HatValue value;
		uint8 padding1;
		uint8 padding2;
	}// JoyHatEvent
	
	[CCode (cname="SDL_JoyButtonEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyButtonEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
		uint8 button;
		uint8 state;
		uint8 padding1;
		uint8 padding2;
	}// JoyButtonEvent
	
	[CCode (cname="SDL_JoyDeviceEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyDeviceEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
	}// JoyDeviceEvent
	
	[CCode (cname="SDL_ControllerAxisEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerAxisEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
		uint8 axis;
		uint8 padding1;
		uint8 padding2;
		uint8 padding3;
		int16 value;
		uint16 padding4;
	}// ControllerAxisEvent
	
	[CCode (cname="SDL_ControllerButtonEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerButtonEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
		uint8 button;
		uint8 state;
		uint8 padding1;
		uint8 padding2;
	}// ControllerButtonEvent
	
	[CCode (cname="SDL_ControllerDeviceEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerDeviceEvent : GenericEvent {
		uint32 windowID;
		SDL.JoystickID which;
	}// ControllerDeviceEvent
	
	[CCode (cname="SDL_TouchFingerEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct TouchFingerEvent : GenericEvent {
		SDL.TouchID touchId;
		SDL.FingerID fingerId;
		float x;
		float y;
		float dx;
		float dy;
		float pressure;
	}// TouchFingerEvent
	
	[CCode (cname="SDL_MultiGestureEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MultiGestureEvent : GenericEvent {
		SDL.TouchID touchId;
		float dTheta;
		float dDist;
		float x;
		float y;
		float pressure;
		uint16 numFingers;
		uint16 padding;
	}// MultiGestureEvent
	
	[CCode (cname="SDL_DollarGestureEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct DollarGestureEvent : GenericEvent {
		SDL.TouchID touchId;
		SDL.GestureID gestureId;
		uint32 numFingers;
		float error;
		float x;
		float y;
	}// DollarGestureEvent
	
	[CCode (cname="SDL_DropEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct DropEvent : GenericEvent {
		uint32 windowID;
		int32 code;
		void *data1;
		void *data2;
	}// DropEvent
	
	[CCode (cname="SDL_UserEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct UserEvent : GenericEvent {
		uint32 windowID;
		string file;
	}// UserEvent
	
	[CCode (cname="SDL_QuitEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct QuitEvent : GenericEvent {}// QuitEvent
	
	[CCode (cname="SDL_TouchID", cheader="SDL2/SDL_touch.h")]
	public struct TouchID {}// TouchID
	
	[CCode (cname="SDL_FingerID", cheader="SDL2/SDL_touch.h")]
	public struct FingerID {}// FingerID
	
	[CCode (cname="SDL_GestureID", cheader="SDL2/SDL_gesture.h")]
	public struct GestureID {}// GestureID
	
	[CCode (cname="SDL_JoystickID", cheader="SDL2/SDL_joystick.h")]
	public struct JoystickID {}// JoystickID
	
	[CCode (cname="SDL_SysWMmsg", cheader="SDL2/SDL_syswm.h")]
	public struct SysWMmsg {}// SysWMmsg

	[CCode (cname="SDL_SysWMEvent", type_id="SDL_SysWMEvent", cheader_filename="SDL2/SDL_events.h")]
	public struct SysWMEvent {
		public SysWMmsg msg;
	}// SysWMEvent
	
	public delegate int EventFilter (void *userdata, SDL.Event ev);
	
	[CCode (cname="SDL_Event", has_type_id=false, has_target=false, destroy_function="", cheader_filename="SDL2/SDL_events.h")]
	[SimpleType]
	public struct Event {
		public SDL.EventType type;
		public SDL.GenericEvent generic;
		public SDL.WindowEvent window;
		public SDL.KeyboardEvent key;
		public SDL.TextEditingEvent edit;
		public SDL.TextInputEvent text;
		public SDL.MouseMotionEvent motion;
		public SDL.MouseButtonEvent button;
		public SDL.MouseWheelEvent wheel; 
		public SDL.JoyAxisEvent jaxis;
		public SDL.JoyBallEvent jball;
		public SDL.JoyHatEvent jhat;
		public SDL.JoyButtonEvent jbutton;
		public SDL.JoyDeviceEvent jdevice;
		public SDL.ControllerAxisEvent caxis;
		public SDL.ControllerButtonEvent cbutton;
		public SDL.ControllerDeviceEvent cdevice;
		public SDL.QuitEvent quit; 
		public SDL.UserEvent user;
		public SDL.SysWMEvent syswm;
		public SDL.TouchFingerEvent tfinger;
		public SDL.MultiGestureEvent mgesture;
		public SDL.DollarGestureEvent dgesture;
		public SDL.DropEvent drop;

		[CCode (cname="SDL_PumpEvents")]
		public static void pump();

		[CCode (cname="SDL_PeepEvents")]
		public static void peep(SDL.Event[] events, int numevents, 
			EventAction action, uint32 minType, uint32 maxType);

		[CCode (cname="SDL_HasEvent")]
		public static bool has_event(SDL.EventType type);

		[CCode (cname="SDL_HasEvents")]
		public static bool has_events(uint32 minType, uint32 maxType);

		[CCode (cname="SDL_FlushEvent")]
		public static void flush_event(SDL.EventType type);

		[CCode (cname="SDL_FlushEvents")]
		public static void flush_events(uint32 minType, uint32 maxType);

		[CCode (cname="SDL_PollEvent")]
		public static int poll(out SDL.Event ev);

		[CCode (cname="SDL_WaitEvent")]
		public static int wait(out SDL.Event ev);

		[CCode (cname="SDL_WaitEventTimeout")]
		public static int wait_inms(out SDL.Event ev, int timeout);

		[CCode (cname="SDL_PushEvent")]
		public static int push(SDL.Event ev);

		[CCode (cname="SDL_SetEventFilter")]
		public static void set_eventfilter(SDL.EventFilter filter, void[] user_data);

		[CCode (cname="SDL_GetEventFilter")]
		public static bool get_eventfilter(SDL.EventFilter filter, out void[] user_data);

		[CCode (cname="SDL_AddEventWatch")]
		public static void add_eventwatch(SDL.EventFilter filter, void[] user_data);

		[CCode (cname="SDL_DelEventWatch")]
		public static void del_eventwatch(SDL.EventFilter filter, void[] user_data);

		[CCode (cname="SDL_FilterEvents")]
		public static void filter_events(SDL.EventFilter filter, void[] user_data);

		[CCode (cname="SDL_EventState")]
		public static uint8 state(SDL.EventType type, SDL.EventState state);

		[CCode (cname="SDL_RegisterEvents")]
		public static uint32 register_events(int numevents);
	}// Event
	
	[CCode (cname="int", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventState {
		QUERY, IGNORE, DISABLE, ENABLE
	}// EventState
	
	[CCode (cname="SDL_eventaction", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventAction {
		ADDEVENT, PEEKEVENT, GETEVENT
	}// EventAction
	

	///
	/// Input
	///
	[CCode (cname="int", cprefix="SDL_")]
	public enum ButtonState {
		RELEASED, PRESSED
	}// ButtonState
	
	[CCode (cname="SDL_Keycode", cprefix="SDLK_", cheader="SDL2/SDL_keyboard.h")]
	public enum Keycode {
		UNKNOWN, RETURN, ESCAPE, BACKSPACE, TAB, SPACE, EXCLAIM,
		QUOTEDBL, HASH, PERCENT, DOLLAR, AMPERSAND, QUOTE,
		LEFTPAREN, RIGHTPAREN, ASTERISK, PLUS, COMMA, MINUS,
		PERIOD, SLASH, SDLK_0, SDLK_1, SDLK_2, SDLK_3, SDLK_4,
		SDLK_5, SDLK_6, SDLK_7, SDLK_8, SDLK_9, COLON, SEMICOLON,
		LESS, EQUALS, GREATER, QUESTION, AT, LEFTBRACKET, BACKSLASH,
		RIGHTBRACKET, CARET, UNDERSCORE, BACKQUOTE, a, b, c, d, e, f,
		g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, CAPSLOCK, F1,
		F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, PRINTSCREEN,
		SCROLLLOCK, PAUSE, INSERT, HOME, PAGEUP, DELETE, END,
		PAGEDOWN, RIGHT, LEFT, DOWN, UP, NUMLOCKCLEAR, KP_DIVIDE,
		KP_MULTIPLY, KP_MINUS, KP_PLUS, KP_ENTER, KP_1, KP_2, KP_3,
		KP_4, KP_5, KP_6, KP_7, KP_8, KP_9, KP_0, KP_PERIOD, APPLICATION,
		POWER, KP_EQUALS, F13, F14, F15, F16, F17, F18, F19, F20, F21,
		F22, F23, F24, EXECUTE, HELP, MENU, SELECT, STOP, AGAIN, UNDO,
		CUT, COPY, PASTE, FIND, MUTE, VOLUMEUP, VOLUMEDOWN, KP_COMMA,
		KP_EQUALSAS400, ALTERASE, SYSREQ, CANCEL, CLEAR, PRIOR,
		RETURN2, SEPARATOR, OUT, OPER, CLEARAGAIN, CRSEL, EXSEL,
		KP_00, KP_000, THOUSANDSSEPARATOR, DECIMALSEPARATOR,
		CURRENCYUNIT, CURRENCYSUBUNIT, KP_LEFTPAREN, KP_RIGHTPAREN,
		KP_LEFTBRACE, KP_RIGHTBRACE, KP_TAB, KP_BACKSPACE, KP_A, KP_B,
		KP_C, KP_D, KP_E, KP_F, KP_XOR, KP_POWER, KP_PERCENT, KP_LESS,
		KP_GREATER, KP_AMPERSAND, KP_DBLAMPERSAND, KP_VERTICALBAR,
		KP_DBLVERTICALBAR, KP_COLON, KP_HASH, KP_SPACE, KP_AT,
		KP_EXCLAM, KP_MEMSTORE, KP_MEMRECALL, KP_MEMCLEAR, KP_MEMADD,
		KP_MEMSUBTRACT, KP_MEMMULTIPLY, KP_MEMDIVIDE, KP_PLUSMINUS,
		KP_CLEAR, KP_CLEARENTRY, KP_BINARY, KP_OCTAL, KP_DECIMAL,
		KP_HEXADECIMAL, LCTRL, LSHIFT, LALT, LGUI, RCTRL, RSHIFT, RALT,
		RGUI, MODE, AUDIONEXT, AUDIOPREV, AUDIOSTOP, AUDIOPLAY,
		AUDIOMUTE, MEDIASELECT, WWW, MAIL, CALCULATOR, COMPUTER,
		AC_SEARCH, AC_HOME, AC_BACK, AC_FORWARD, AC_STOP, AC_REFRESH,
		AC_BOOKMARKS, BRIGHTNESSDOWN, BRIGHTNESSUP, DISPLAYSWITCH,
		KBDILLUMTOGGLE, KBDILLUMDOWN, KBDILLUMUP, EJECT, SLEEP
	}// Keycode
	
	[CCode (cname="SDL_Keymod", cprefix="KMOD_", cheader="SDL2/SDL_keyboard.h")]
	public enum Keymod {
		NONE, LSHIFT, RSHIFT, LCTRL, RCTRL, LALT, RALT,
		LGUI, RGUI, NUM, CAPS, MODE, RESERVED,
		CTRL, SHIFT, ALT, GUI
	}// Keymod
		
	[CCode (cname="SDL_Scancode", cprefix="SDL_SCANCODE_", cheader="SDL2/SDL_scancode.h")]
	public enum Scancode {
		UNKNOWN, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R,
		S, T, U, V, W, X, Y, Z,
		SDL_SCANCODE_1, SDL_SCANCODE_2,
		SDL_SCANCODE_3, SDL_SCANCODE_4, SDL_SCANCODE_5,
		SDL_SCANCODE_6, SDL_SCANCODE_7, SDL_SCANCODE_8,
		SDL_SCANCODE_9, SDL_SCANCODE_0,
		RETURN, ESCAPE, BACKSPACE, TAB, SPACE, MINUS, EQUALS,
		LEFTBRACKET, RIGHTBRACKET, BACKSLASH, NONUSHASH,
		SEMICOLON, APOSTROPHE, GRAVE, COMMA, PERIOD, SLASH,
		CAPSLOCK, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
		PRINTSCREEN, SCROLLLOCK, PAUSE, INSERT, HOME,
		PAGEUP, DELETE, END, PAGEDOWN, RIGHT, LEFT, DOWN, UP,
		NUMLOCKCLEAR, KP_DIVIDE, KP_MULTIPLY, KP_MINUS, KP_PLUS,
		KP_ENTER, KP_1, KP_2, KP_3, KP_4, KP_5, KP_6, KP_7, KP_8,
		KP_9, KP_0, KP_PERIOD, NONUSBACKSLASH, APPLICATION,
		POWER, KP_EQUALS, F13, F14, F15, F16, F17, F18, F19, F20,
		F21, F22, F23, F24, EXECUTE, HELP, MENU, SELECT, STOP,
		AGAIN, UNDO, CUT, COPY, PASTE, FIND, MUTE, VOLUMEUP,
		VOLUMEDOWN, LOCKINGCAPSLOCK, LOCKINGNUMLOCK,
		LOCKINGSCROLLLOCK, KP_COMMA, KP_EQUALSAS400,
		INTERNATIONAL1, INTERNATIONAL2, INTERNATIONAL3,
		INTERNATIONAL4, INTERNATIONAL5, INTERNATIONAL6,
		INTERNATIONAL7, INTERNATIONAL8, INTERNATIONAL9, LANG1,
		LANG2, LANG3, LANG4, LANG5, LANG6, LANG7, LANG8,
		LANG9, ALTERASE, SYSREQ, CANCEL, CLEAR, PRIOR, RETURN2,
		SEPARATOR, OUT, OPER, CLEARAGAIN, CRSEL, EXSEL, KP_00,
		KP_000, THOUSANDSSEPARATOR, DECIMALSEPARATOR,
		CURRENCYUNIT, CURRENCYSUBUNIT, KP_LEFTPAREN,
		KP_RIGHTPAREN, KP_LEFTBRACE, KP_RIGHTBRACE, KP_TAB,
		KP_BACKSPACE, KP_A, KP_B, KP_C, KP_D, KP_E, KP_F, KP_XOR,
		KP_POWER, KP_PERCENT, KP_LESS, KP_GREATER, KP_AMPERSAND,
		KP_DBLAMPERSAND, KP_VERTICALBAR, KP_DBLVERTICALBAR,
		KP_COLON, KP_HASH, KP_SPACE, KP_AT, KP_EXCLAM, KP_MEMSTORE,
		KP_MEMRECALL, KP_MEMCLEAR, KP_MEMADD, KP_MEMSUBTRACT,
		KP_MEMMULTIPLY, KP_MEMDIVIDE, KP_PLUSMINUS, KP_CLEAR,
		KP_CLEARENTRY, KP_BINARY, KP_OCTAL, KP_DECIMAL,
		KP_HEXADECIMAL, LCTRL, LSHIFT, LALT, LGUI, RCTRL, RSHIFT, RALT,
		RGUI, MODE, AUDIONEXT, AUDIOPREV, AUDIOSTOP, AUDIOPLAY,
		AUDIOMUTE, MEDIASELECT, WWW, MAIL, CALCULATOR, COMPUTER,
		AC_SEARCH, AC_HOME, AC_BACK, AC_FORWARD, AC_STOP, AC_REFRESH,
		AC_BOOKMARKS, BRIGHTNESSDOWN, BRIGHTNESSUP, DISPLAYSWITCH,
		KBDILLUMTOGGLE, KBDILLUMDOWN, KBDILLUMUP, EJECT, SLEEP, APP1, APP2
	}// Scancode
	
	[CCode (cname="SDL_Keysym", cheader="SDL2/SDL_keyboard.h")]
	public class Key {
		SDL.Scancode scancode;
		SDL.Keycode sym;
		uint16 mod;
		uint32 unicode;
	}// Key
	
	[CCode (cheader="SDL2/SDL_keyboard.h")]
	public class Keyboard {
		[CCode (cname="SDL_GetKeyboardFocus")]
		public static SDL.Window get_focus();
		
		[CCode (cname="SDL_GetKeyboardState")]
		public static uint8[] get_state(int[] numkeys);
		
		[CCode (cname="SDL_GetModState")]
		public static SDL.Keymod get_modifierstate();
		
		[CCode (cname="SDL_SetModState")]
		public static void set_modifierstate(SDL.Keymod modstate);
		
		[CCode (cname="SDL_GetKeyFromScancode")]
		public static SDL.Keycode key_fromscancode(SDL.Scancode scancode);
		
		[CCode (cname="SDL_GetScancodeFromName")]
		public static SDL.Scancode scancode_fromkey(SDL.Keycode key);
		
		[CCode (cname="SDL_GetScancodeName")]
		public static unowned string get_scancodename(SDL.Scancode scancode);
		
		[CCode (cname="SDL_GetScancodeFromName")]
		public static SDL.Scancode scancode_fromname(string name);
		
		[CCode (cname="SDL_GetKeyName")]
		public static unowned string get_keyname(SDL.Keycode key);
		
		[CCode (cname="SDL_GetKeyFromName")]
		public static SDL.Keycode keycode_fromname(string name);
	}// Keyboard
	
	[CCode (cheader="SDL2/SDL_keyboard.h")]
	public class TextInput {
		[CCode (cname="SDL_StartTextInput")]
		public static void start();
		
		[CCode (cname="SDL_IsTextInputActive")]
		public static bool is_active();
		
		[CCode (cname="SDL_StopTextInput")]
		public static void stop();
		
		[CCode (cname="SDL_SetTextInputRect")]
		public static void set_rect(SDL.Rect rect);
	}// TextInput
	
	[CCode (cheader="SDL2/SDL_keyboard.h")]
	public class ScreenKeyboard {
		[CCode (cname="SDL_HasScreenKeyboardSupport")]
		public static bool has_support();
		
		[CCode (cname="SDL_IsScreenKeyboardShown")]
		public static bool is_shown(SDL.Window window);
	}
	
	[CCode (cname="SDL_SystemCursor", cprefix="SDL_SYSTEM_CURSOR_", cheader="SDL2/SDL_mouse.h")]
	public enum SystemCursor {
		ARROW, IBEAM, WAIT, CROSSHAIR, WAITARROW, SIZENWSE,
		SIZENESW, SIZEWE, SIZENS, SIZEALL, NO, HAND,
		[CCode(cname="SDL_NUM_SYSTEM_CURSORS")]
		NUM
	}// SystemCursor

	[CCode (cname="Uint8", cprefix="SDL_BUTTON_")]
	public enum MouseButton {
		LEFT, MIDDLE, RIGHT, X1, X2,
		LMASK, MMASK, RMASK, 
		X1MASK,  X2MASK
	}// Buttons
	
	[CCode (type_id="SDL_Cursor", free_function="SDL_FreeCursor", cheader="SDL2/SDL_mouse.h")]
	[Compact]
	public class Cursor {
		[CCode (cname="SDL_GetMouseFocus")]
		public static SDL.Window get_focus();
		
		[CCode (cname="SDL_GetMouseState")]
		public static uint32 get_state(ref int x, ref int y);

		[CCode (cname="SDL_GetRelativeMouseState")]
		public static uint32 get_relative_state(ref int x, ref int y);

		[CCode (cname="SDL_WarpMouse")]
		public static void warp_inwindow(SDL.Window window, int x, int y);

		[CCode (cname="SDL_SetRelativeMouseMode")]
		public static int set_relative_mode(bool enabled);

		[CCode (cname="SDL_GetRelativeMouseState")]
		public static bool get_relative_mode();

		[CCode (cname="SDL_CreateCursor")]
		public Cursor(uint8* data, uint8* mask, int w, int h, 
			int hot_x, int hot_y);

		[CCode (cname="SDL_CreateCursor")]
		public Cursor.from_color(SDL.Surface surface, int hot_x, int hot_y);

		[CCode (cname="SDL_SystemCursor")]
		public Cursor.from_system(SDL.SystemCursor id);

		[CCode (cname="SDL_SetCursor")]
		public static void set(SDL.Cursor cursor);

		[CCode (cname="SDL_GetCursor")]
		public static SDL.Cursor get();

		[CCode (cname="SDL_ShowCursor")]
		public static int show(int toggle);
	}// Cursor
	
	[CCode (cname="SDL_JoystickGUID", cheader="SDL2/SDL_joystick.h")]
	public struct JoystickGUID{
		uint8 data[16];
	}

	[CCode (cname="SDL_Joystick", free_function="SDL_JoystickClose", cheader="SDL2/SDL_joystick.h")]
	[Compact]
	public class Joystick {
		[CCode (cname="SDL_NumJoysticks")]
		public static int count();

		[CCode (cname="SDL_JoystickNameForIndex")]
		public static unowned string name_forindex(int device_index);

		[CCode (cname="SDL_JoystickOpen")]
		public Joystick(int device_index);

		[CCode (cname="SDL_JoystickName")]
		public static unowned string get_name(int device_index);
		
		[CCode (cname="SDL_JoystickGetDeviceGUID")]
		public static SDL.JoystickGUID get_guid_from_device(int device_index);
		
		[CCode (cname="SDL_JoystickGetGUID")]
		public SDL.JoystickGUID get_guid();
		
		[CCode (cname="SDL_JoystickGetGUIDString")]
		public static void guid_string(SDL.JoystickGUID  guid, string psz, int cb);
		
		[CCode (cname="SDL_JoystickGetGUIDFromString")]
		public static SDL.JoystickGUID get_guid_from_string(string pch);
		
		[CCode (cname="SDL_JoystickGetAttached")]
		public bool get_attached();
		
		[CCode (cname="SDL_JoystickInstanceID")]
		public static SDL.JoystickID get_instance();
		
		[CCode (cname="SDL_JoystickNumAxes")]
		public int num_axes();

		[CCode (cname="SDL_JoystickNumBalls")]
		public int num_balls();

		[CCode (cname="SDL_JoystickNumHats")]
		public int num_hats();

		[CCode (cname="SDL_JoystickNumButtons")]
		public int num_buttons();
		
		[CCode (cname="SDL_JoystickUpdate")]
		public static void update();
		
		[CCode (cname="SDL_JoystickGetAxis")]
		public int16 get_axis(int axis);
		
		[CCode (cname="SDL_JoystickGetHat")]
		public SDL.HatValue get_hat(int hat);

		[CCode (cname="SDL_JoystickGetBall")]
		public SDL.HatValue get_ball(int ball, ref int dx, ref int dy);

		[CCode (cname="SDL_JoystickGetButton")]
		public SDL.ButtonState get_button(int button);
	}// Joystick
	
	[CCode (cname="SDL_Finger", type_id="SDL_Finger", cheader="SDL2/SDL_touch.h")]
	public class Finger {
		SDL.FingerID id;
		float x;
		float y;
		float pressure;
		
		[CCode (cname="SDL_TOUCH_MOUSEID")]
		public static uint32 TOUCH_MOUSEID;
		
		[CCode (cname="SDL_GetNumTouchDevices")]
		public static int count_devices();
		
		[CCode (cname="SDL_GetTouchDevice")]
		public static SDL.TouchID get_device(int index);
		
		[CCode (cname="SDL_GetNumTouchFingers")]
		public static int count_fingers(SDL.TouchID touchId);
		
		[CCode (cname="SDL_GetTouchFinger")]
		public Finger(SDL.TouchID touchId, int index);
	}// Finger
	
	
	///
	/// Audio
	///
	[CCode (cname="Uint16", cprefix="AUDIO_", cheader="SDL2/SDL_audio.h")]
	public enum AudioFormat {
		U8, S8, U16LSB, S16LSB, U16MSB, S16MSB, U16, S16,
		S32LSB, S32MSB, S32, F32LSB, F32MSB, F32,
		U16SYS, S16SYS, U32SYS, S32SYS,
	}// AudioFormat

	[CCode (cname="int", cprefix="SDL_AUDIO_")]
	public enum AudioStatus {
		STOPPED, PLAYING, PAUSED
	}// AudioStatus
	
	[CCode (cname="int", cprefix="SDL_AUDIO_ALLOW_", cheader="SDL2/SDL_audio.h")]
	public enum AudioAllowFlags {
		FREQUENCY_CHANGE,
		FORMAT_CHANGE,
		CHANNELS_CHANGE,
		ANY_CHANGE
	}// AudioAllowFlags

	[CCode (cname="SDL_AudioCallback", instance_pos = 0.1, cheader="SDL2/SDL_audio.h")]
	public delegate void AudioCallback(void *userdata, uint8[] stream, int len);

	[CCode (cname="SDL_AudioSpec", cheader="SDL2/SDL_audio.h")]
	public struct AudioSpec {
		public int freq;
		public SDL.AudioFormat format;
		public uint8 channels;
		public uint8 silence;
		public uint16 samples;
		public uint16 padding;
		public uint32 size;
		[CCode (delegate_target_cname = "userdata")]
		public unowned SDL.AudioCallback callback;
	}// AudioSpec
	
	[CCode (cname="SDL_AudioFilter", instance_pos = 0.1, cheader="SDL2/SDL_audio.h")]
	public delegate void AudioFilter(AudioConverter cvt, AudioFormat format);

	[CCode (cname="SDL_AudioCVT", cheader="SDL2/SDL_audio.h")]
	[Compact]
	public class AudioConverter {
		public int needed;
		public SDL.AudioFormat src_format;
		public SDL.AudioFormat dst_format;
		public double rate_incr;

		public uint8* buf;
		public int len;
		public int len_cvt;
		public int len_mult;
		public double len_ratio;
		public SDL.AudioFilter filters[10];
		public int filter_index;

		[CCode (cname="SDL_BuildAudioCVT")]
		public static int build(AudioConverter cvt, AudioFormat src_format, 
			uchar src_channels, int src_rate, AudioFormat dst_format, 
			uchar dst_channels, int dst_rate);

		[CCode (cname="SDL_ConvertAudio")]
		public int convert();
	}// AudioConverter
	
	[CCode (cname="SDL_AudioDeviceID", cheader="SDL2/SDL_audio.h")]
	public struct AudioDeviceID {}// AudioDeviceID

	[CCode (cheader="SDL2/SDL_audio.h")]
	[Compact]
	public class Audio {
		[CCode (cname="SDL_GetNumAudioDrivers")]
		public static int count_drivers();
		
		[CCode (cname="SDL_GetAudioDriver")]
		public static unowned string get_driver(int index);
		
		[CCode (cname="SDL_AudioInit")]
		public static int init(string driver);
		
		[CCode (cname="SDL_AudioQuit")]
		public static void quit();
		
		[CCode (cname="SDL_GetAudioDriver")]
		public static unowned string get_currentdriver();
		
		[CCode (cname="SDL_OpenAudio")]
		public static int open(AudioSpec desired, out AudioSpec obtained);
		
		[CCode (cname="SDL_GetNumAudioDevices")]
		public static int count_devices();
		
		[CCode (cname="SDL_GetAudioDeviceName")]
		public static unowned string get_devicename(int index);
		
		[CCode (cname="SDL_OpenAudioDevice")]
		public static SDL.AudioDeviceID open_device(string device,
			int iscapture, SDL.AudioSpec desired, SDL.AudioSpec obtained,
				int allowed_changes);

		[CCode (cname="SDL_GetAudioStatus")]
		public static SDL.AudioStatus status();

		[CCode (cname="SDL_GetAudioDeviceStatus")]
		public static SDL.AudioStatus status_device(SDL.AudioDeviceID dev);
		
		[CCode (cname="SDL_PauseAudio")]
		public static void pause(int pause_on);
		
		[CCode (cname="SDL_PauseAudioDevice")]
		public static void pause_device(SDL.AudioDeviceID dev, int pause_on);
		
		[CCode (cname="SDL_LoadWAV_RW")]
		public static unowned AudioSpec? load_rw(RWops src, int freesrc=0, ref AudioSpec spec, out uint8[] audio_buf, out uint32 audio_len);

		public static unowned AudioSpec? load(string file, ref AudioSpec spec, out uint8[] audio_buf, out uint32 audio_len){
			load_rw(new SDL.RWops.from_file(file, "rb"), 1,
			ref spec, out audio_buf, out audio_len);
		}
		
		[CCode (cname="SDL_FreeWAV")]
		public static void free(ref uint8 audio_buf);
		
		[CCode (cname="SDL_MixAudio")]
		public static void mix(out uint8[] dst, uint8[] src, uint32 len, int volume);
		
		[CCode (cname="SDL_MixAudioFormat")]
		public static void mix_device(out uint8[] dst, uint8[] src, SDL.AudioFormat format, uint32 len, int volume);

		[CCode (cname="SDL_LockAudio")]
		public static void do_lock();

		[CCode (cname="SDL_UnlockAudio")]
		public static void unlock();

		[CCode (cname="SDL_LockAudioDevice")]
		public static void do_lock_device(SDL.AudioDeviceID dev);

		[CCode (cname="SDL_LockAudioDevice")]
		public static void unlock_device(SDL.AudioDeviceID dev);

		[CCode (cname="SDL_CloseAudio")]
		public static void close();

		[CCode (cname="SDL_CloseAudioDevice")]
		public static void close_device(SDL.AudioDeviceID dev);

		[CCode (cname="SDL_AudioDeviceConnected")]
		public static int is_device_connected(SDL.AudioDeviceID dev);
	}// Audio
	
	
	///
	/// Timers
	///
	[CCode (cname="SDL_TimerCallback", cheader="SDL2/SDL_timer.h")]
	public delegate uint32 TimerCallback(uint32 interval,  void *param);

	[CCode (cname="SDL_TimerID", ref_function="", unref_function="", cheader="SDL2/SDL_timer.h")]
	[Compact]
	public class Timer {
		[CCode (cname="SDL_GetTicks")]
		public static uint32 get_ticks();

		[CCode (cname="SDL_GetPerformanceCounter")]
		public static uint64 get_performance_counter();

		[CCode (cname="SDL_GetPerformanceFrequency")]
		public static uint64 get_performance_frequency();

		[CCode (cname="SDL_Delay")]
		public static void delay(uint32 ms);

		[CCode (cname="SDL_AddTimer")]
		public Timer (uint32 interval, SDL.TimerCallback callback, void *param);
		
		[CCode (cname="SDL_RemoveTimer")]
		public bool remove ();
	}// Timer
	
	// TODO: Threading
}// SDL