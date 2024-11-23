extends CharacterBody2D

@export_group("nodes")
@export var sprite: Sprite2D
@export var animation: AnimationPlayer
@export var gui: CanvasLayer
@export_group("")

func _ready() -> void:
	CameraManager.change_owner(self)

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

func _on_refined_wood_wall_button_pressed():
	if ConstructionManager.buildMode == false:
		ConstructionManager.change_build_mode_object(ConstructionManager.constructions.refinedWoodWall)
		ConstructionManager.turn_build_mode_on()
	else:
		ConstructionManager.turn_build_mode_off()
