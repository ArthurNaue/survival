extends Node2D

func _on_spawn_resource_object_timer_timeout() -> void:
	WorldManager.spawn_resource_object()
