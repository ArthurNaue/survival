extends Camera2D

var shakeFade := 5.0

var rng = RandomNumberGenerator.new()
var shakeStrength: float = 0.0

var currentCamera: GameCamera

func apply_shake(strength: float) -> void:
	shakeStrength = strength

func change_owner(newOwner: Node2D) -> void:
	var camera = GameCamera.new()
	newOwner.add_child(camera)
	if currentCamera:
		currentCamera.queue_free()
	currentCamera = camera

func _process(_delta: float) -> void:
	if shakeStrength > 0:
		shakeStrength = lerp(shakeStrength, 0.0, shakeFade * _delta)
		currentCamera.offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))
