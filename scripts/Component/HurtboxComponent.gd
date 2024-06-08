extends Area2D
class_name HurtboxComponent

@export var healthComponent : HealthComponent

func damage(dmg:Attack):
	healthComponent.damage(dmg)

