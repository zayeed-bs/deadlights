extends Area2D
class_name HurtboxComponent

@export var healthComponent : HealthComponent

func damage(dmg:Attack, atkPos:Vector2):
	healthComponent.damage(dmg)
	get_parent().knockback = -dmg.base_kb * global_position.direction_to(atkPos)
