extends Node2D

func play_sound(desiredSound: AudioStreamWAV, location: Vector2, volume := 0):
	var sound = GameSound.new()
	sound.stream = desiredSound
	sound.global_position = location
	sound.autoplay = true
	sound.volume_db = volume
	WorldManager.get_world().add_child(sound)
