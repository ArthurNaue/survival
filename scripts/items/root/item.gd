extends StaticBody2D
class_name Item

@export_group("nodes")
@export var sprite: Sprite2D
@export var amountText: RichTextLabel
@export_group("")

@export var stats: ItemStats
@export_range(1, 64) var amount: int

func _ready() -> void:
	update_values()

func update_values() -> void:
	sprite.texture = stats.sprite
	amountText.text = "[center] x" + str(amount)

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("player"):
		PlayerManager.update_resources(stats, amount, PlayerManager.operation.add)
		queue_free()

func _on_items_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("item"):
		WorldManager.merge_items(self, _area.owner)
