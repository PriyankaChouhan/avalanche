namespace Shooter {

public class Main : Aval.Game {
	// Window static width
	public static const int WW = 800;
	// Window static height
	public static const int WH = 480;
	
	public static Rand RANDOM;
	
	#if AVALANCE_WIN
		[CCode (cname="WinMain")]
	#else
		#if AVALANCHE_ANDROID
			[CCode (cname="Java_avalanche_Launcher_start")]
		#endif
	#endif
	public static int main () {
		// Intialize SDL, SDLImage and Avalanche.
		init(SDL.InitFlag.EVERYTHING, SDLImage.InitFlags.PNG);
		
		// Initialize SDLMixer
		SDLMixer.open (48000, SDL.AudioFormat.S16SYS, 2, 4096);
		
		// Initialize our random number generator
		RANDOM = new Rand();
		
		// Setup Avalanche
		// If you're using SDL.RendererFlags.PRESENTVSYNC you must set this to 0
		set_fps (60);
		
		// Create window and render separately.
		WINDOW = new SDL.Window ("Shooter", SDL.Window.POS_CENTERED,
			SDL.Window.POS_CENTERED, WW, WH, SDL.WindowFlags.SHOWN);
		WIN_RENDERER = new SDL.Renderer (WINDOW, -1, SDL.RendererFlags.ACCELERATED);
		
		// Select the first screenstate
		change_state (new Splash ("../res/mainMenu.png", new Game1 ()));
		
		// Core
		while (STATE != null) {
			STATE.on_enter (); // Welcome...
			main_loop (); // ...to the work
		}
		
		// Quit SDL and valanche module.
		quit ();
		
		return 0;
	}
}// Main


}// Shooter