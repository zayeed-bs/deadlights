extends Node

enum attacks {
	HIGH_GUARD,
	STAB,
	SLASH
}

# Called when the node enters the scene tree for the first time.
func _ready(): # Replace with function body.
	genAttack(3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func genAttack(n_attack:int):
	var attackList = []
	
	for i in n_attack:
		var val = randi_range(1,3)
		
		match val:
			1:
				var atk = Attack.new()
				attackList.append(atk)
	
	
