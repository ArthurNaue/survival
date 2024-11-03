extends CharacterBody2D

@export_group("nodes")
@export var sprite: Sprite2D
@export var animation: AnimationPlayer
@export var gui: CanvasLayer

func _physics_process(_delta: float) -> void:
	#movement
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	moveVector.y = Input.get_action_strength("S") - Input.get_action_strength("W")
	moveVector = moveVector.normalized()
	
	if moveVector:
		animation.play("walk")
		velocity = moveVector * 200
	else:
		animation.play("idle")
		velocity = Vector2.ZERO

	move_and_slide()
	
	$gui/wood/woodAmountText.text = "[center]" + str(PlayerManager.resources[PlayerManager.materialType.wood])
	$gui/stone/stoneAmountText.text = "[center]" + str(PlayerManager.resources[PlayerManager.materialType.stone])
	$gui/iron/ironAmountText.text = "[center]" + str(PlayerManager.resources[PlayerManager.materialType.iron])

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("TAB"):
		gui.visible = true
	else:
		gui.visible = false

func _on_furnance_button_pressed() -> void:
	if ConstructionManager.buildMode == false:
		ConstructionManager.change_build_mode_object(ConstructionManager.constructions.furnance)
		ConstructionManager.turn_build_mode_on()
	else:
		ConstructionManager.turn_build_mode_off()

func _on_crafting_station_button_pressed() -> void:
	if ConstructionManager.buildMode == false:
		ConstructionManager.change_build_mode_object(ConstructionManager.constructions.craftingStation)
		ConstructionManager.turn_build_mode_on()
	else:
		ConstructionManager.turn_build_mode_off()
