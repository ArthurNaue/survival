extends Node2D

const constructionObjectScene = preload("res://scenes/constructions/root/construction.tscn")

var constructions := {
	"furnance": load("res://resources/constructionObjects/furnance/root/furnanceStats.tres")
}

var buildMode := false
var constructionSprite: Sprite2D

func _process(_delta: float) -> void:
	if ConstructionManager.buildMode == true:
		constructionSprite.global_position = get_global_mouse_position()
		if get_player().gui.visible == false:
			constructionSprite.modulate = Color.GREEN
		else:
			constructionSprite.modulate = Color.RED

func spawn_construction_object(object: ConstructionObjectsStats, location: Vector2) -> void:
	var construction = constructionObjectScene.instantiate() as ConstructionObject
	construction.stats = object
	construction.global_position = location
	WorldManager.get_world().add_child(construction)
	turn_build_mode_false()

func turn_build_mode_on(spriteTexture: Texture) -> void:
	buildMode = true
	constructionSprite = Sprite2D.new()
	constructionSprite.global_position = get_global_mouse_position()
	constructionSprite.texture = spriteTexture
	add_child(constructionSprite)

func turn_build_mode_false() -> void:
	buildMode = false
	constructionSprite.queue_free()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("M1") and ConstructionManager.buildMode == true and get_player().gui.visible == false:
		spawn_construction_object(ConstructionManager.constructions.furnance, get_global_mouse_position())

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
