extends CharacterBody2D

@export var meleeComponent : MeleeHitboxComponent
@export var SPEED := 150
var dir : Vector2
@onready var animTree := $AnimationTree

var attack_float : float
var in_lock_on_range := true


func _physics_process(delta):
	handleMovement() # For the movement
	handleAnimation() # Change Parameters
	handleCombat(delta) # For Attacks



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

	
func handleCombat(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack_float += delta
	else:
		if attack_float > 0.7:
			# Implement Secondary (Not Unlocked when beginning)
			print("Heavy Attack")
		elif attack_float > 0:
			# Implement Primary
			print("Light Attack")
		
		attack_float = 0
		
	$"Control/Mouse Button held down".set_text(str(attack_float))
