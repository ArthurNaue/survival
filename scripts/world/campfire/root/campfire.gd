extends StaticBody2D

@export var animation: AnimationPlayer
@export var stats: ResourceObjectsStats
@export var healthComponent: HealthComponent
@export var healthBarComponent: HealthBarComponent
@export var damageCooldownTimer: Timer

@onready var interactTextComponent = $interactTextComponent
@onready var interactText = $interactText

var interactable := false
var enemies: Array
var damageCooldown := false

var dialogues := [
	"IT REMINDS YOU OF HOME",
	"A PLACE TO COMEBACK TO",
	"FELLS WARM",
	"IF IT BURNS YOU'RE OK"
]

func _ready() -> void:
	healthBarComponent.visible = false

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
	if !interactable and !interactText.visible and _area.owner.is_in_group("player"):
		interactTextComponent.switch_visibility.emit()
		interactable = true
	elif _area.owner.is_in_group("enemies"):
		enemies.append(_area.owner)
		verify_damage()

func _on_hitbox_area_exited(_area: Area2D) -> void:
	if _area.owner:
		if interactable and _area.owner.is_in_group("player"):
			interactTextComponent.switch_visibility.emit()
			interactable = false
		elif _area.owner.is_in_group("enemies"):
			enemies.erase(_area.owner)
			verify_damage()
	else: 
		await get_tree().create_timer(0.1).timeout
		for enemy in enemies:
			if str(enemy) == "<Freed Object>":
				enemies.erase(enemy)

func verify_damage() -> void:
	if enemies and damageCooldown == false:
		damageCooldown = true
		damageCooldownTimer.start()
		healthComponent.damage(1)
		healthBarComponent.visible = true
		await get_tree().create_timer(0.5).timeout
		healthBarComponent.visible = false

func _on_damage_cooldown_timer_timeout() -> void:
	if enemies:
		verify_damage()
		damageCooldown = false
	else:
		damageCooldown = false
		damageCooldownTimer.stop()
