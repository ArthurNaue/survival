extends Node2D

func play_sound(desiredSound: AudioStreamWAV, location: Vector2, volume := 0):
	var sound = GameSound.new()
	sound.stream = desiredSound
	sound.global_position = location
	sound.autoplay = true
	sound.volume_db = volume
	WorldManager.get_world().get_node("sounds").add_child(sound)

func spawn_particle(particleScene: PackedScene, desiredPosition: Vector2) -> void:
	var particle = particleScene.instantiate() as CPUParticles2D
	particle.global_position = desiredPosition
	WorldManager.get_world().add_child(particle)
	particle.emitting = true
