extends Node2D

@export var debug = false
@export var fpsLabel : Label


func _ready():
	# Dialogic.start('prototype_timeline')
	pass

func _process(delta):
	if debug:
		fpsLabel.set_text("FPS " + str(Engine.get_frames_per_second()))
