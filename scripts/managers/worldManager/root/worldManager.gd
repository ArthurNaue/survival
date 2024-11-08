extends Node2D

const itemDropScene = preload("res://scenes/items/root/item.tscn")
const resourceObject = preload("res://scenes/resourceObjects/root/resourceObjects.tscn")

var resourceObjects := [
	load("res://resources/resourceObjects/tree/root/treeStats.tres"),
	load("res://resources/resourceObjects/rock/root/rockStats.tres"),
	load("res://resources/resourceObjects/ironRock/root/ironRockStats.tres"),
	load("res://resources/resourceObjects/goldRock/root/goldRock.tres")
]

var spawnedResourceObjects := 0

func spawn_item_drop(itemStats, location: Vector2) -> void:
	var itemDrop = itemDropScene.instantiate() as StaticBody2D
	itemDrop.stats = itemStats
	get_world().add_child(itemDrop)
	itemDrop.global_position = location

func spawn_resource_object():
	if spawnedResourceObjects < 100:
		spawnedResourceObjects+= 1
		var resource = resourceObject.instantiate() as ResourceObjects
		resource.stats = resourceObjects.pick_random()
		var location = Vector2(randi_range(0, 1000), randi_range(0, 1000))
		while location.distance_to(get_tree().get_first_node_in_group("player").global_position) < 200:
			location = Vector2(randi_range(0, 1000), randi_range(0, 1000))
		get_world().add_child(resource)
		resource.global_position = location

func get_world() -> Node2D:
	return get_tree().get_first_node_in_group("world")
