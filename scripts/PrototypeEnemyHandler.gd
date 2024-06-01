extends CharacterBody2D

enum {
	IDLE,
	CHASE,
	ATTACK
}

@export var SPEED := 50
var player
var state = IDLE
var rng = RandomNumberGenerator.new()
@onready var attackTimer  = $ChaseRange/Timer


func _ready():
	rng.randomize()

func _physics_process(delta):
	match state:
		IDLE:
			# idle()
			pass
		CHASE:
			chase()
		ATTACK:
			attack()


func idle():
	# TO DO THIS DOES NOT WORK
	# NEED A TIMER HERE SO IT DOESN'T GO BONKERS
	velocity = Vector2(rng.randf_range(-0.5,0.5), rng.randf_range(-0.5,0.5)) * SPEED
	move_and_slide()

func chase():
	if player:
		velocity = global_position.direction_to(player.global_position) * SPEED
	move_and_slide()


func attack():
	# Generate number of attacks
	# Then play animations
	# Handle Damage
	pass
	
func _on_chase_range_area_entered(area):
	# check if object in area is actually player
	if(area != $HurtboxComponent && area is HurtboxComponent):
		player = area # attach player
		state = CHASE # change state
		attackTimer.start(1.5) # change state to attack after player has been in there for a while


func _on_chase_range_area_exited(area):
	if(area != $HurtboxComponent && area is HurtboxComponent):
		player = null # detach player
		state = IDLE # change state to idle



func _on_timer_timeout():
	state = ATTACK # Replace with function body.
