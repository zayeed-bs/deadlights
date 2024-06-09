extends Node2D

@export var debug = false
@export var fpsLabel : Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if debug:
		fpsLabel.set_text("FPS " + str(Engine.get_frames_per_second()))
