extends Node
class_name HealthComponent

@export var MAX_HEALTH := 100
@export var HEALTH_DISPLAY : RichTextLabel
var health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH # Replace with function body.
	updateHealthDisplay()


func damage(dmg:int):
	health -= dmg
	updateHealthDisplay()
	
	if health <= 0:
		get_parent().queue_free()

func updateHealthDisplay():
	if(HEALTH_DISPLAY):
		HEALTH_DISPLAY.text = "Health: " + str(health)
