extends StaticBody2D

@export_group("nodes")
@export var sprite: Sprite2D
@export_group("")

@export var stats: ItemStats

func _ready() -> void:
	sprite.texture = stats.sprite

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("player"):
		PlayerManager.update_resources(stats, PlayerManager.operation.add)
		queue_free()
