extends Node2D

func play_sound(desiredSound: AudioStreamWAV, location: Vector2):
	var sound = GameSound.new()
	sound.stream = desiredSound
	sound.global_position = location
	sound.autoplay = true
	WorldManager.get_world().add_child(sound)
