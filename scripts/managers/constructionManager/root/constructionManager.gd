extends Node2D

const constructionObjectScene = preload("res://scenes/constructions/root/construction.tscn")

enum constructionTypes {
	craftingStation,
	wall
}

var constructions := {
	"furnance": load("res://resources/constructionObjects/furnance/root/furnanceStats.tres"),
	"craftingStation": load("res://resources/constructionObjects/craftingStation/root/craftingStationStats.tres"),
	"refinedWoodWall" : load("res://resources/constructionObjects/refinedWoodWall/root/refinedWoodWallStats.tres")
}

var buildMode := false
var constructionSprite: Sprite2D
var constructionObject: ConstructionObjectsStats
var tutorialText: RichTextLabel
var object: ConstructionObjectsStats

func _process(_delta: float) -> void:
	if ConstructionManager.buildMode == true:
		tutorialText.global_position = Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y)
		constructionSprite.global_position = get_global_mouse_position()
		if get_player().gui.visible == false and check_requirements():
			constructionSprite.modulate = Color.GREEN
		else:
			constructionSprite.modulate = Color.RED

func spawn_construction_object(location: Vector2) -> void:
	if check_requirements():
		for requirement in constructionObject.requirementNumber:
			PlayerManager.update_resources(requirement, PlayerManager.operation.sub)
		var construction = constructionObjectScene.instantiate() as ConstructionObject
		construction.stats = object
		construction.global_position = location
		construction.sprite.rotation_degrees = constructionSprite.rotation_degrees
		WorldManager.get_world().add_child(construction)
		turn_build_mode_off()

func change_build_mode_object(newObject: ConstructionObjectsStats) -> void:
	object = newObject

func turn_build_mode_on() -> void:
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
	var requirementsNumber := 0
	var requirementsMet := false
	for requirement in constructionObject.requirementNumber:
		requirementsNumber += 1
		if PlayerManager.check_resources(requirement):
			requirementsNumber -= 1
	if requirementsNumber <= 0:
		requirementsMet = true
	return requirementsMet

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("M1") and buildMode == true and get_player().gui.visible == false:
		spawn_construction_object(get_global_mouse_position())
	if Input.is_action_just_pressed("Q") and buildMode == true:
		turn_build_mode_off()
	if Input.is_action_just_pressed("R") and buildMode == true:
		constructionSprite.rotation_degrees += 90

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
