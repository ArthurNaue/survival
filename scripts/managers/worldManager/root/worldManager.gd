extends Node2D

const itemDropScene = preload("res://scenes/items/root/item.tscn")
const resourceObject = preload("res://scenes/resourceObjects/root/resourceObjects.tscn")

const resourceObjects := [
	preload("res://resources/resourceObjects/tree/root/treeStats.tres"),
	preload("res://resources/resourceObjects/rock/root/rockStats.tres"),
	preload("res://resources/resourceObjects/ironRock/root/ironRockStats.tres"),
	preload("res://resources/resourceObjects/goldRock/root/goldRock.tres")
]

const enemies := [
	preload("res://scenes/entities/enemies/rectangleEnemy/root/rectangleEnemy.tscn"),
	preload("res://scenes/entities/enemies/triangleEnemy/root/triangleEnemy.tscn")
]

var spawnedResourceObjects := 0
var mergeItemNumber := 0
var night := false

func spawn_item_drop(itemStats: ItemStats, amount: int, location: Vector2) -> void:
	var itemDrop = itemDropScene.instantiate() as StaticBody2D
	itemDrop.stats = itemStats
	itemDrop.amount = amount
	get_world().call_deferred("add_child", itemDrop)
	itemDrop.global_position = location

func merge_items(firstItem: Item, secondItem: Item):
	if firstItem.stats.type == secondItem.stats.type:
		mergeItemNumber += 1
		if mergeItemNumber == 2:
			var amount = firstItem.amount + secondItem.amount
			spawn_item_drop(firstItem.stats, amount, firstItem.global_position)
			firstItem.queue_free()
			secondItem.queue_free()
			mergeItemNumber = 0

func spawn_resource_object() -> void:
	if spawnedResourceObjects < 100:
		var resource = resourceObject.instantiate() as ResourceObjects
		resource.stats = resourceObjects.pick_random()
		var location = Vector2(randi_range(0, 1000), randi_range(0, 1000))
		while location.distance_to(get_tree().get_first_node_in_group("player").global_position) < 200 or location.distance_to(get_world().get_node("navRegion").get_node("campfire").global_position) < 200:
			location = Vector2(randi_range(0, 1000), randi_range(0, 1000))
		get_world().resourceObjects.add_child(resource)
		resource.global_position = location

func spawn_enemy() -> void:
	var enemy = enemies.pick_random().instantiate() as EnemiesClass
	var enemyPosition = Vector2(randi_range(0, 1000), randi_range(0, 1000))
	while enemyPosition.distance_to(WorldManager.get_world().get_node("navRegion").get_node("campfire").global_position) < 200:
		enemyPosition = Vector2(randi_range(0, 1000), randi_range(0, 1000))
	enemy.global_position = enemyPosition
	get_world().add_child(enemy)

func change_day_time() -> void:
	night = !night

func get_nav_region() -> NavigationRegion2D:
	return get_world().get_node("navRegion")

func get_world() -> Node2D:
	return get_tree().get_first_node_in_group("world")
