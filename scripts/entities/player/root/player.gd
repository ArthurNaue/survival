extends CharacterBody2D

@export_group("nodes")
@export var sprite: Sprite2D
@export var animation: AnimationPlayer

var buildMode := false
var constructionSprite: Sprite2D

func _physics_process(_delta: float) -> void:
	if buildMode == true:
		constructionSprite.global_position = get_global_mouse_position()
	
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
	
	$gui/wood/woodAmountText.text = "[center]" + str(PlayerManager.wood)
	$gui/stone/stoneAmountText.text = "[center]" + str(PlayerManager.rock)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("TAB"):
		$gui.visible = true
	else:
		$gui.visible = false
	
	if Input.is_action_just_pressed("M1") and !Input.is_action_pressed("TAB") and buildMode == true:
		var construction = ConstructionManager.constructions.furnance.instantiate() as ConstructionObject
		WorldManager.get_world().add_child(construction)
		construction.global_position = get_global_mouse_position()
		buildMode = false
		constructionSprite.queue_free()

func _on_furnance_button_pressed() -> void:
	if buildMode == false:
		buildMode = true
		constructionSprite = Sprite2D.new()
		constructionSprite.global_position = get_global_mouse_position()
		constructionSprite.texture = $gui/furnance.texture
		add_child(constructionSprite)
	else:
		buildMode = false
		constructionSprite.queue_free()
