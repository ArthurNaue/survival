extends Node2D

const resourcesGUIScene = preload("res://scenes/entities/player/gui/resources/root/resourcesGUI.tscn")
var resourcesGUIs: Array[ResourcesGUI]
var yGUI: int
var xGUI: int

const wood = preload("res://resources/items/resources/wood/root/woodStats.tres")
const refinedWood = preload("res://resources/items/resources/wood/refinedWood/root/refinedWoodStats.tres")
const stone = preload("res://resources/items/resources/stone/root/stoneStats.tres")
const rawIron = preload("res://resources/items/resources/iron/rawIron/root/rawIronStats.tres")
const iron = preload("res://resources/items/resources/iron/root/ironStats.tres")
const rawGold = preload("res://resources/items/resources/gold/rawGold/root/rawGoldStats.tres")
const gold = preload("res://resources/items/resources/gold/root/goldStats.tres")

enum materialType {
	wood,
	refinedWood,
	stone,
	rawIron,
	iron,
	rawGold,
	gold
}

enum operation {
	add,
	sub
}

var itemStats := {
	materialType.wood: load("res://resources/items/resources/wood/root/woodStats.tres"),
	materialType.refinedWood: load("res://resources/items/resources/wood/refinedWood/root/refinedWoodStats.tres"),
	materialType.stone: load("res://resources/items/resources/stone/root/stoneStats.tres"),
	materialType.rawIron: load("res://resources/items/resources/iron/rawIron/root/rawIronStats.tres"),
	materialType.rawGold: load("res://resources/items/resources/gold/rawGold/root/rawGoldStats.tres"),
	materialType.gold: load("res://resources/items/resources/gold/root/goldStats.tres"),
	materialType.iron: load("res://resources/items/resources/iron/root/ironStats.tres")
}

var resources := {
	materialType.wood: 0,
	materialType.refinedWood: 0,
	materialType.stone: 0,
	materialType.rawIron: 0,
	materialType.rawGold: 0,
	materialType.gold: 0,
	materialType.iron: 0
}

var resourcesSprites := {
	materialType.wood: wood.sprite,
	materialType.refinedWood: refinedWood.sprite,
	materialType.stone: stone.sprite,
	materialType.rawIron: rawIron.sprite,
	materialType.rawGold: rawGold.sprite,
	materialType.gold: gold.sprite,
	materialType.iron: iron.sprite
}

func update_resources(item: ItemStats, amount: int, currentOperation: int):
	if currentOperation == operation.sub:
		resources[item.type] -= amount
		if resources[item.type] == 0:
			destroy_resource_GUI(item)
	else:
		if resources[item.type] == 0:
			create_resource_GUI(item)
		resources[item.type] += amount
	
	for resourceGUI in resourcesGUIs:
		if resourceGUI.value == item.type:
			resourceGUI.update_values()

func check_resources(item: ItemStats) -> bool:
	var returnValue := false
	if resources[item.type] > 0:
		returnValue = true
	return returnValue

func create_resource_GUI(resource: ItemStats) -> void:
	var resourceGUI = resourcesGUIScene.instantiate() as ResourcesGUI
	resourceGUI.value = resource.type
	get_player().get_node("gui").add_child(resourceGUI)
	resourcesGUIs.append(resourceGUI)
	sort_GUI()

func destroy_resource_GUI(resource: ItemStats) -> void:
	for resourcesGUI in resourcesGUIs:
		if resourcesGUI.value == resource.type:
			resourcesGUI.queue_free()
			resourcesGUIs.erase(resourcesGUI)
	sort_GUI()

func sort_GUI() -> void:
	xGUI = 50
	yGUI = 500
	for resourcesGUI in resourcesGUIs:
		resourcesGUI.position.y = yGUI
		resourcesGUI.position.x = xGUI
		xGUI += 50
		if xGUI > 200:
			xGUI = 50
			yGUI += 50

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
