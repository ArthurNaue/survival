extends Node2D
class_name ResourcesGUI

@export var sprite: Sprite2D
@export var text: RichTextLabel
@export var dropSound: AudioStream

var value: PlayerManager.materialType
var item: ItemStats

func _ready() -> void:
	item = PlayerManager.itemStats[value]
	
	update_values()

func update_values() -> void:
	sprite.texture = PlayerManager.resourcesSprites[value]
	text.text = "[center]" + str(PlayerManager.resources[value])

func _on_drop_button_pressed() -> void:
	var player = PlayerManager.get_player()
	GameManager.play_sound(dropSound, PlayerManager.get_player().global_position)
	WorldManager.spawn_item_drop(item, PlayerManager.resources[value], Vector2(player.global_position.x, player.global_position.y + 25))
	PlayerManager.update_resources(item, PlayerManager.resources[value], PlayerManager.operation.sub)
	PlayerManager.destroy_resource_GUI(item)
