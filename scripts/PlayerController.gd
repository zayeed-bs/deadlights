extends CharacterBody2D

@export var SPEED := 50

func _physics_process(delta):
	var xAxis = Input.get_axis("ui_left", "ui_right")
	var yAxis = Input.get_axis("ui_up", "ui_down")
	
	velocity = Vector2(xAxis, yAxis).normalized() * SPEED
	move_and_slide()
