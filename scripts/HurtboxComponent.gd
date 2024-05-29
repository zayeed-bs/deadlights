extends Area2D
class_name HurtboxComponent

@export var healthComponent : HealthComponent

func damage(dmg:int):
	healthComponent.damage(dmg)
