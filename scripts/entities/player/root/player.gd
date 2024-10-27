extends CharacterBody2D

@export_group("nodes")
@export var sprite: Sprite2D
@export var animation: AnimationPlayer

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
	
	$gui/woodAmountText.text = "[center]" + str(PlayerManager.wood)
	$gui/rockAmountText.text = "[center]" + str(PlayerManager.rock)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("TAB"):
		$gui.visible = true
	else:
		$gui.visible = false
