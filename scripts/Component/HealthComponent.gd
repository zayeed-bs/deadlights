extends Node
class_name HealthComponent

@export var MAX_HEALTH := 100
@export var HEALTH_DISPLAY : Label
@export var INVINCIBLE := false
@export var DAMAGE_COOLDOWN := 0.5
var health: int

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH # Replace with function body.
	updateHealthDisplay() # Set Initial Health Text


func damage(dmg:Attack):
	if !INVINCIBLE:
		health -= dmg.raw_damage # Update Health
		updateHealthDisplay() # Update Display
	
	if health <= 0: # Delete Entity if HP goes down to 0
		get_parent().queue_free()
	else:
		INVINCIBLE = true
		timer.start(DAMAGE_COOLDOWN)

func heal(val:int):
	health += val
	clamp(health, 0, MAX_HEALTH) # Clamp Health to the Max Health
	updateHealthDisplay()

func updateHealthDisplay():
	if(HEALTH_DISPLAY):
		HEALTH_DISPLAY.set_text("Health: " + str(health))


func _on_timer_timeout():
	INVINCIBLE = false
