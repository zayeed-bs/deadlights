extends CanvasModulate

@export var colorGradient : GradientTexture1D
@export var totalDurationPerDayInSeconds : int = 600
@export var lightFadeDurationInSeconds : float = 5.0
@export var timeLabel : Label
var time : float = 0.00
var lightsOn : bool = true
@onready var lights : Array[Node] = get_tree().get_nodes_in_group("EnvironmentLights")

func _ready():
	if lightsOn: # Turn off
		for light in lights:
			light.energy = 0
			lightsOn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	# a * sinbx + c
	# amplitude -> 1
	# +1.0 /2.0 to shift into range (0->1)
	# +0.25pi so it starts at morning (6am)
	# (2*PI)/totalDurationPerDayInSeconds to match duration
	var val = (sin((2*PI)/totalDurationPerDayInSeconds*time + 0.75*PI) + 1.0) / 2.0
	color = colorGradient.gradient.sample(val) # 1.0 is full day, 0.0 is full night
	
	# Switch the lights // Uses toggle for efficiency
	if(val >= 0.6):
		if lightsOn: # Turn off
			for light in lights:
				lightsOn = false
				
				# Fade out the lights
				var tween = get_tree().create_tween()
				tween.tween_property(light, "energy", 0, 5)
	else:
		if !lightsOn: # Turn on
			for light in lights:
				var tween = get_tree().create_tween()
				tween.tween_property(light, "energy", 1, 5)
				lightsOn = true
	
	var mins = roundi(1440 * (time/totalDurationPerDayInSeconds)) % 1440
	timeLabel.set_text(str((roundi(mins/60) + 9) % 24) + ":" + str(roundi(mins%60)))
	
	
