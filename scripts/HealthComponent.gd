extends Node
class_name HealthComponent

@export var MAX_HEALTH := 100
@export var HEALTH_DISPLAY : RichTextLabel
var health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH # Replace with function body.
	updateHealthDisplay() # Set Initial Health Text


func damage(dmg:int):
	health -= dmg # U pdate Health
	updateHealthDisplay() # Update Display
	
	if health <= 0: # Delete Entity if HP goes down to 0
		get_parent().queue_free()

func heal(val:int):
	health += val
	clamp(health, 0, MAX_HEALTH) # Clamp Health to the Max Health
	updateHealthDisplay()

func updateHealthDisplay():
	if(HEALTH_DISPLAY):
		HEALTH_DISPLAY.text = "Health: " + str(health)
