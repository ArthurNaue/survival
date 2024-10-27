extends StaticBody2D
class_name ConstructionObject

@onready var interactText = $interactText
@onready var animation = $anim

@export var stats: ConstructionObjectsStats

@export_group("nodes")
@export var sprite: Sprite2D

func _ready() -> void:
	sprite.texture = stats.sprite

func make_item() -> void:
	if PlayerManager.check_resources(stats.firstIngredient) and PlayerManager.check_resources(stats.secondIngredient):
		PlayerManager.update_resources(stats.firstIngredient, "-")
		PlayerManager.update_resources(stats.secondIngredient, "-")
		WorldManager.spawn_item_drop(stats.resultItem, Vector2(global_position.x, global_position.y + 30))
		animation.play("use")

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("player"):
		interactText.visible = true

func _on_hitbox_area_exited(_area: Area2D) -> void:
	if _area.owner.is_in_group("player"):
		interactText.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and interactText.visible == true:
		make_item()
