extends StaticBody2D
class_name Item

@export_group("nodes")
@export var sprite: Sprite2D
@export var amountText: RichTextLabel
@export var anim: AnimationPlayer
@export var pickupSound: AudioStream
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
		GameManager.play_sound(pickupSound, PlayerManager.get_player().global_position)
		anim.play("pickup")

func _on_items_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("item"):
		WorldManager.merge_items(self, _area.owner)

func _on_anim_animation_finished(_anim) -> void:
	if _anim == "pickup":
		queue_free()
