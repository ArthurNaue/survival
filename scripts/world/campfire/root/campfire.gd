extends StaticBody2D

@export var animation: AnimationPlayer

@onready var interactTextComponent = $interactTextComponent
@onready var interactText = $interactText

var interactable := false

var dialogues := [
	"IT REMINDS YOU OF HOME",
	"A PLACE TO COMEBACK TO",
	"FELLS WARM",
	"IF IT BURNS IM OK"
]

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and interactable:
		interactTextComponent.switch_visibility.emit()
		interactText.text = "[center]" + dialogues.pick_random()
		interactText.visible = true
		interactable = false
		await get_tree().create_timer(3).timeout
		interactText.visible = false

func turn_lights_on() -> void:
	animation.play("anim")

func turn_lights_off() -> void:
	animation.stop()

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if !interactable and !interactText.visible:
		interactTextComponent.switch_visibility.emit()
		interactable = true

func _on_hitbox_area_exited(_area: Area2D) -> void:
	if interactable:
		interactTextComponent.switch_visibility.emit()
		interactable = false
