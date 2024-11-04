extends StaticBody2D
class_name ConstructionObject

@onready var interactText = $interactTextComponent
@onready var animation = $anim

@export var stats: ConstructionObjectsStats

@export_group("nodes")
@export var sprite: Sprite2D

func _ready() -> void:
	sprite.texture = stats.sprite

func make_item() -> void:
	var ingredientNumber := 0
	var ingredientMet: bool
	for ingredient in stats.ingredientsNumber:
		ingredientNumber += 1
		if PlayerManager.check_resources(ingredient):
			ingredientNumber -= 1
	if ingredientNumber <= 0:
		ingredientMet = true
	if ingredientMet:
		for ingredient in stats.ingredientsNumber:
			PlayerManager.update_resources(ingredient, PlayerManager.operation.sub)
		WorldManager.spawn_item_drop(stats.resultItem, Vector2(global_position.x, global_position.y + 30))
		animation.play("use")

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("player") and stats.constructionType == ConstructionManager.constructionTypes.craftingStation:
		interactText.switch_visibility.emit()

func _on_hitbox_area_exited(_area: Area2D) -> void:
	if _area.owner.is_in_group("player") and stats.constructionType == ConstructionManager.constructionTypes.craftingStation:
		interactText.switch_visibility.emit()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and interactText.visible == true:
		make_item()
