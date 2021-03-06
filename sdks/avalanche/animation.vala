/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 */

namespace Aval {

public class Animation {
	private unowned SDL.Graphics.Texture spritesheet;
	public SDL.Graphics.Point screen_pos;
	public double angle;
	public SDL.Graphics.RendererFlip flip;
	public bool infinite;
	protected uint16 frame_width;
	protected uint16 frame_height;
	protected uint8 actual_x;
	protected uint8 actual_y;
	private uint8 first_x;
	private uint8 last_x;
	private uint8 last_y;
	private SDL.Graphics.Rect input;
	private SDL.Graphics.Rect output;
	private uint8 counter;
	private uint8 frame_time;
	
	public Animation (SDL.Graphics.Texture _spritesheet, uint16 _frame_width, uint16 _frame_height, uint8 last_frame_x, uint8 last_frame_y, uint8 start_frame_y, uint8 frame_time, SDL.Graphics.Point screen_pos, uint8 first_x = 0) {
		this.spritesheet = _spritesheet;
		this.frame_width = _frame_width;
		this.frame_height = _frame_height;
		this.last_x = last_frame_x;
		this.last_y = last_frame_y;
		this.actual_y = start_frame_y;
		this.screen_pos = screen_pos;
		this.first_x = first_x;
		this.frame_time = frame_time;
		this.counter = 0;
		this.angle = 0;
		this.flip = SDL.Graphics.RendererFlip.NONE;
		this.infinite = true;
		update_rects ();
	}
	
	public uint8 get_x () {
		return actual_x;
	}
	
	public uint8 get_y () {
		return actual_y;
	}
	
	public void set_x (uint8 nvalue) {
		actual_x = nvalue;
		while (actual_x > last_x)
			actual_x = last_x;
	}
	
	public void next () {
		if (actual_x >= last_x) {
			if(infinite) actual_x = first_x;
		} else
			actual_x++;
	}
	
	public void tick () {
		counter++;
		if (counter > frame_time){
			next ();
			counter = 0;
		}
	}
	
	public void set_y (uint8 nvalue) {
		actual_y = nvalue;
		while (actual_y > last_y)
			actual_y = last_y;
	}
	
	public void set_mask (Aval.AnimationMask mask) {
		actual_y = mask.y;
		first_x = mask.first_x;
		actual_x = mask.first_x;
		last_x = mask.last_x;
		this.infinite = mask.infinite;
	}
	
	public void update_rects () {
		input = {frame_width * actual_x, frame_height * actual_y, frame_width, frame_height};
		output = {screen_pos.x, screen_pos.y, frame_width, frame_height};
	}
	
	public void draw () {
		Aval.Game.WIN_RENDERER.copyex (spritesheet, input, output, angle, null, flip);
	}
}// Animation

public struct AnimationMask {
	public uint8 y;
	public uint8 first_x;
	public uint8 last_x;
	public bool infinite;
}// AnimationMask


}// Aval