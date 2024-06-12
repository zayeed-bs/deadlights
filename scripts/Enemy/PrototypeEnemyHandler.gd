extends CharacterBody2D

enum states{
	IDLE,
	CHASE,
	ATTACK,
	AVOID
}

@export var SPEED := 50
@export var stateLabel : Label
var player
var state = states.IDLE
var isAttacking = false
var dir = Vector2.ZERO
var rng = RandomNumberGenerator.new()

@onready var attackTimer  = $AttackRange/Timer
@onready var hurtBox = $HurtboxComponent
@onready var animTree = $AnimationTree
@onready var animPlayer = $AnimationPlayer
@onready var debugLabel = $Health
@onready var atkRange = $AttackRange
@onready var chaseRange = $ChaseRange

func _ready():
	rng.randomize()

func _physics_process(delta):
	match state:
		states.IDLE:
			idle()
		states.CHASE:
			chase()
		states.ATTACK:
			attack()
	
	animTree["parameters/Idle/blend_position"] = dir
	animTree["parameters/Run/blend_position"] = dir
	animTree["parameters/Attack/blend_position"] = dir

func idle():
	# TO DO THIS DOES NOT WORK
	# NEED A TIMER HERE SO IT DOESN'T GO BONKERS
	animTree["parameters/conditions/is_idle"] = true
	animTree["parameters/conditions/is_moving"] = false
	
	if player != null:
		if chaseRange.overlaps_area(player):
			state = states.CHASE
	

func chase():
	print()
	if atkRange.overlaps_area(player): # Check if player is still attackable
		state = states.ATTACK
	else:
		if player != null:
			dir = global_position.direction_to(player.global_position).normalized()
			velocity = dir * SPEED
			move_and_slide()
			
		animTree["parameters/conditions/is_idle"] = false
		animTree["parameters/conditions/is_moving"] = true
		animTree["parameters/conditions/is_attacking"] = false
	



func attack():
	# Generate number of attacks
	# Then play animations
	# Handle Damage
	animTree["parameters/conditions/is_moving"] = false
	animTree["parameters/conditions/is_idle"] = false
	animTree["parameters/conditions/is_attacking"] = true
	isAttacking = true
	velocity = Vector2.ZERO
	
	move_and_slide()
	
	
func _on_chase_range_area_entered(area):
	# check if object in area is actually player
	if(area != hurtBox && area is HurtboxComponent && !isAttacking):
		player = area # attach player
		state = states.CHASE # change state

func _on_chase_range_area_exited(area):
	if(area != hurtBox && area is HurtboxComponent && !isAttacking):
		player = null # detach player
		state = states.IDLE # change state to idle


func _on_timer_timeout():	
	if atkRange.overlaps_area(player): # Check if player is still attackable
		state = states.ATTACK
		

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "attack_right"):
		animTree["parameters/conditions/is_attacking"] = false
		isAttacking = false
	
		state = states.IDLE
		attackTimer.start(0.2)
