extends StaticBody2D
class_name ConstructionObject

const useSound = preload("res://assets/audio/constructionObjects/craftingStations/root/craftingStation.wav")
const shootSound = preload("res://assets/audio/constructionObjects/turrets/root/shootConstructionAudio.wav")

@onready var interactText = $interactTextComponent
@onready var animation = $anim

@export var stats: ConstructionObjectsStats

@export_group("nodes")
@export var sprite: Sprite2D
@export var turretCooldownTimer: Timer

var target: CharacterBody2D

func _ready() -> void:
	sprite.texture = stats.sprite
	
	if stats.constructionType == ConstructionManager.constructionTypes.turret:
		turretCooldownTimer.wait_time = stats.cooldown

func make_item() -> void:
	var ingredientNumber := 0
	var ingredientMet: bool
	for ingredient in stats.ingredientsNumber:
		ingredientNumber += 1
		if PlayerManager.check_resources(ingredient):
			ingredientNumber -= 1
	if ingredientNumber <= 0:
		ingredientMet = true
	if ingredientMet:
		for ingredient in stats.ingredientsNumber:
			PlayerManager.update_resources(ingredient, 1, PlayerManager.operation.sub)
		WorldManager.spawn_item_drop(stats.resultItem, 1, Vector2(global_position.x, global_position.y + 30))
		animation.play("use")
		GameManager.play_sound(useSound, global_position)

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("player") and stats.constructionType == ConstructionManager.constructionTypes.craftingStation:
		interactText.switch_visibility.emit()

func _on_hitbox_area_exited(_area: Area2D) -> void:
	if _area.owner.is_in_group("player") and stats.constructionType == ConstructionManager.constructionTypes.craftingStation:
		interactText.switch_visibility.emit()

func _on_enemy_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("enemies") and stats.constructionType == ConstructionManager.constructionTypes.turret:
		target = _area.owner
		turretCooldownTimer.start()

func _on_enemy_hitbox_area_exited(_area: Area2D) -> void:
	turretCooldownTimer.stop()

func _on_turret_cooldown_timeout() -> void:
	animation.play("shoot")
	GameManager.play_sound(shootSound, global_position)
	CameraManager.apply_shake(1)
	target.get_node("entitiesHealthComponent").damage(stats.damage)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and interactText.visible == true:
		make_item()
