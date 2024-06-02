extends Area2D
class_name MeleeHitboxComponent

@export var DAMAGE := 30
@export var attackProp : Attack
@export var ownHurtbox: HurtboxComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_entered(area): # If a Hurtbox has been found, damage that entity
	if(area is HurtboxComponent and area != ownHurtbox):
		area.damage(attackProp)
