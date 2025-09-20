extends OmniLight3D

@export var noise: NoiseTexture2D
@export var flicker_speed: float = 1
var time_passed: float

func _process(delta: float) -> void:
	time_passed += flicker_speed * delta
	
	var sampled_noise: float = noise.noise.get_noise_1d(time_passed)
	sampled_noise = abs(sampled_noise)

	if (sampled_noise >= 0.075): sampled_noise = 0.5
	else: sampled_noise = 0.25

	light_energy = sampled_noise
