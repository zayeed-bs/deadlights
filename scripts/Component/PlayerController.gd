extends CharacterBody2D

@export var meleeComponent : MeleeHitboxComponent
@export var SPEED := 150
var dir : Vector2
@onready var animTree := $AnimationTree



func _physics_process(delta):
	handleMovement() # For the movement
	handleAnimation() # Change Parameters



func handleMovement():
	# Get Input
	var xAxis = Input.get_axis("ui_left", "ui_right")
	var yAxis = Input.get_axis("ui_up", "ui_down")
	
	# Normalized Direction
	dir = Vector2(xAxis, yAxis).normalized()
	
	# Calculate Velocity
	velocity = dir * SPEED
	move_and_slide()


func handleAnimation():
	if velocity != Vector2.ZERO: # currently moving
		animTree["parameters/conditions/is_running"] = true
		animTree["parameters/conditions/is_idle"] = false
		
		# Change blend position
		animTree["parameters/Run/blend_position"] = dir
		animTree["parameters/Idle/blend_position"] = dir
		
	else: # idle
		animTree["parameters/conditions/is_running"] = false
		animTree["parameters/conditions/is_idle"] = true
		
	#animTree["parameters/conditions/is_shooting"] = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	
	
