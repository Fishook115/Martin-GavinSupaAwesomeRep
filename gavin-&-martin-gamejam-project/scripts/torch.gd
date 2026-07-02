#extends MeshInstance3D
#

#
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	print(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("music_recorder")))
#	#light.light_energy = lerp(light.light_energy, remap(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")), 10.0, 20.0, 2.0, 6.0), delta * 2)
#	pass
extends MeshInstance3D

@onready var light : OmniLight3D = $MeshInstance3D/MeshInstance3D/MeshInstance3D/OmniLight3D
@export var frequency_range : Vector2 = Vector2(0, 4000)

var smoothing: float = 4

var spectrum: AudioEffectSpectrumAnalyzerInstance
var bus_index: int

func _ready():
	# Find the index of the bus playing your music (e.g., 0 for "Master")
	bus_index = AudioServer.get_bus_index("music")
	# Get the spectrum analyzer effect
	spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)

func _process(delta):
	if not spectrum:
		return

	# Grab the magnitude for a frequency range. 
	# (Use 0 to 4000 to capture most standard music volume)
	var magnitude2d = spectrum.get_magnitude_for_frequency_range(500, 3000)
	
	# Calculate the overall volume level (combining left and right channels)
	var volume = magnitude2d.length()
	#print(volume)
	# Amplify the volume since it usually returns a very small float
	
	
	# Smoothly transition the light energy so it flickers naturally
	light.light_energy = lerp(light.light_energy, remap(volume, 0.009, 0.025, 1.0, 8.0), delta * smoothing)
