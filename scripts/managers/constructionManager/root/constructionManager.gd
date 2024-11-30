extends Node2D

const constructionObjectScene = preload("res://scenes/constructions/root/construction.tscn")
const constructSound = preload("res://assets/audio/constructionObjects/construct/root/constructSound.wav")

enum constructionTypes {
	craftingStation,
	wall
}

enum constructions {
	furnance,
	craftingStation,
	refinedWoodWall
}

var constructionsStats := {
	constructions.furnance: load("res://resources/constructionObjects/furnance/root/furnanceStats.tres"),
	constructions.craftingStation: load("res://resources/constructionObjects/craftingStation/root/craftingStationStats.tres"),
	constructions.refinedWoodWall: load("res://resources/constructionObjects/refinedWoodWall/root/refinedWoodWallStats.tres")
}

var buildMode := false
var constructionObject: ConstructionObjectsStats
var constructionSprite := Sprite2D.new()
var tutorialText := RichTextLabel.new()
var constructionObjectColision := Area2D.new()
var colided := false
var constructionObjectShapeColision := CollisionShape2D.new()
var object: ConstructionObjectsStats
var warningTextExists := false

func _process(_delta: float) -> void:
	if ConstructionManager.buildMode == true:
		tutorialText.global_position = Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y)
		constructionSprite.global_position = get_global_mouse_position()
		constructionObjectColision.global_position = get_global_mouse_position()
		constructionObjectShapeColision.global_position = get_global_mouse_position()

func spawn_construction_object(location: Vector2) -> void:
	for requirement in constructionObject.requirementNumber:
		PlayerManager.update_resources(requirement, 1, PlayerManager.operation.sub)
	var construction = constructionObjectScene.instantiate() as ConstructionObject
	construction.stats = object
	construction.global_position = location
	construction.sprite.rotation_degrees = constructionSprite.rotation_degrees
	WorldManager.get_world().constructionObjects.add_child(construction)
	GameManager.play_sound(constructSound, location)
	CameraManager.apply_shake(1)
	turn_build_mode_off()

func change_build_mode_object(newObject: ConstructionObjectsStats) -> void:
	object = newObject

func turn_build_mode_on() -> void:
	buildMode = true
	constructionObject = object
	constructionSprite = Sprite2D.new()
	tutorialText.text = "Q / CANCEL
R / ROTATE"
	tutorialText.size = Vector2(150, 50)
	tutorialText.scale = Vector2(0.25, 0.25)
	constructionObjectColision.set_collision_mask_value(3, true)
	constructionObjectColision.area_entered.connect(_unable_to_build)
	constructionObjectColision.area_exited.connect(_able_to_build)
	constructionObjectShapeColision.shape = RectangleShape2D.new()
	constructionObjectShapeColision.shape.size = Vector2(32, 32)
	constructionSprite.texture = object.sprite
	if Input.is_action_pressed("TAB"):
		_unable_to_build()
	else:
		_able_to_build()
	add_child(constructionObjectColision)
	constructionObjectColision.add_child(constructionObjectShapeColision)
	add_child(constructionSprite)
	add_child(tutorialText)

func turn_build_mode_off() -> void:
	buildMode = false
	constructionSprite.texture = null
	tutorialText.text = ""
	_unable_to_build()

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
	if Input.is_action_just_pressed("TAB"):
		_unable_to_build()
	elif Input.is_action_just_released("TAB"):
		_able_to_build()
	
	if Input.is_action_just_pressed("M1") and buildMode:
		if check_requirements():
			if !colided:
				if !get_player().gui.visible:
					spawn_construction_object(get_global_mouse_position())
				else:
					warning_text("Turn the GUI off!")
			else:
				warning_text("Something in the way!")
		else:
			warning_text("Not enough resources!")
	if Input.is_action_just_pressed("Q") and buildMode == true:
		turn_build_mode_off()
	if Input.is_action_just_pressed("R") and buildMode == true:
		constructionSprite.rotation_degrees += 90

func _able_to_build(_area: Area2D = null) -> void:
	colided = false

func _unable_to_build(_area: Area2D = null) -> void:
	colided = true

func warning_text(text: String) -> void:
	if !warningTextExists:
		var warningText = RichTextLabel.new()
		warningText.bbcode_enabled = true
		warningText.size = Vector2(200, 50)
		warningText.pivot_offset = Vector2(100, 25)
		warningText.scale = Vector2(2, 2)
		warningText.text = "[center]" + text
		warningText.position = Vector2(550, 600)
		PlayerManager.get_player().get_node("gui").add_child(warningText)
		warningTextExists = true
		await get_tree().create_timer(1).timeout
		warningText.queue_free()
		warningTextExists = false

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
