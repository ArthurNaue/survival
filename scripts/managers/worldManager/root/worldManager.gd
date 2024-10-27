extends Node2D

const itemDropScene = preload("res://scenes/items/root/item.tscn")

var resourceObjects := [
	load("res://scenes/world/tree/root/tree.tscn"),
	load("res://scenes/world/rock/root/rock.tscn")
]


func spawn_item_drop(itemStats: ItemStats, location: Vector2) -> void:
	var itemDrop = itemDropScene.instantiate() as StaticBody2D
	itemDrop.stats = itemStats
	get_world().add_child(itemDrop)
	itemDrop.global_position = location

func spawn_resource_object():
	var resource = resourceObjects.pick_random().instantiate() as ResourceObjects
	var location = Vector2(randi_range(0, 1000), randi_range(0, 1000))
	while location.distance_to(get_tree().get_first_node_in_group("player").global_position) < 200:
		location = Vector2(randi_range(0, 1000), randi_range(0, 1000))
	get_world().add_child(resource)
	resource.global_position = location

func get_world() -> Node2D:
	return get_tree().get_first_node_in_group("world")
