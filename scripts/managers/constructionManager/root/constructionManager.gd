extends Node2D

const constructionObjectScene = preload("res://scenes/constructions/root/construction.tscn")

var constructions := {
	"furnance": load("res://resources/constructionObjects/furnance/root/furnanceStats.tres"),
	"craftingStation": load("res://resources/constructionObjects/craftingStation/root/craftingStationStats.tres")
}

var buildMode := false
var constructionSprite: Sprite2D
var constructionObject: ConstructionObjectsStats
var tutorialText: RichTextLabel

func _process(_delta: float) -> void:
	if ConstructionManager.buildMode == true:
		tutorialText.global_position = Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y)
		constructionSprite.global_position = get_global_mouse_position()
		if get_player().gui.visible == false and check_requirements():
			constructionSprite.modulate = Color.GREEN
		else:
			constructionSprite.modulate = Color.RED

func spawn_construction_object(object: ConstructionObjectsStats, location: Vector2) -> void:
	if check_requirements():
		PlayerManager.update_resources(object.firstRequirement, PlayerManager.operation.sub)
		PlayerManager.update_resources(object.secondRequirement, PlayerManager.operation.sub)
		var construction = constructionObjectScene.instantiate() as ConstructionObject
		construction.stats = object
		construction.global_position = location
		construction.sprite.rotation_degrees = constructionSprite.rotation_degrees
		WorldManager.get_world().add_child(construction)
		turn_build_mode_off()

func turn_build_mode_on(object: ConstructionObjectsStats) -> void:
	buildMode = true
	tutorialText = RichTextLabel.new()
	tutorialText.text = "Q / CANCEL
R / ROTATE"
	tutorialText.size = Vector2(150, 50)
	tutorialText.scale = Vector2(0.25, 0.25)
	constructionSprite = Sprite2D.new()
	constructionSprite.texture = object.sprite
	constructionObject = object
	add_child(constructionSprite)
	add_child(tutorialText)

func turn_build_mode_off() -> void:
	buildMode = false
	constructionSprite.queue_free()
	tutorialText.queue_free()

func check_requirements() -> bool:
	var requirementsMet := false
	if PlayerManager.check_resources(constructionObject.firstRequirement) and PlayerManager.check_resources(constructionObject.secondRequirement):
		requirementsMet = true
	return requirementsMet

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("M1") and buildMode == true and get_player().gui.visible == false:
		spawn_construction_object(constructionObject, get_global_mouse_position())
	if Input.is_action_just_pressed("Q") and buildMode == true:
		turn_build_mode_off()
	if Input.is_action_just_pressed("R") and buildMode == true:
		constructionSprite.rotation_degrees += 90

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
