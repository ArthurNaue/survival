extends Node2D

const constructionsGUIScene = preload("res://scenes/entities/player/gui/constructions/root/constructionsGUI.tscn")
const resourcesGUIScene = preload("res://scenes/entities/player/gui/resources/root/resourcesGUI.tscn")
var constructionsGUIs: Array[ConstructionsGUI]
var resourcesGUIs: Array[ResourcesGUI]
var xResourceGUI: int
var yResourceGUI: int
var xConstructionGUI: int
var yConstructionGUI: int

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
	
	var _currentConstruction := 0
	
	for construction in ConstructionManager.constructions:
		var requirementsMet := true
		var alreadyCreated := false
		for requirement in ConstructionManager.constructionsStats[_currentConstruction].requirementNumber:
			if !PlayerManager.check_resources(requirement):
				requirementsMet = false
		if requirementsMet:
			for constructionGUI in PlayerManager.constructionsGUIs:
				if constructionGUI.construction == ConstructionManager.constructionsStats[_currentConstruction]:
					alreadyCreated = true
			if !alreadyCreated:
				create_construction_GUI(ConstructionManager.constructionsStats[_currentConstruction])
		_currentConstruction += 1

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

func create_construction_GUI(construction: ConstructionObjectsStats) -> void:
	var constructionGUI = constructionsGUIScene.instantiate() as ConstructionsGUI
	constructionGUI.construction = construction
	get_player().get_node("gui").add_child(constructionGUI)
	constructionsGUIs.append(constructionGUI)
	sort_GUI()

func destroy_resource_GUI(resource: ItemStats) -> void:
	for resourcesGUI in resourcesGUIs:
		if resourcesGUI.value == resource.type:
			resourcesGUI.queue_free()
			resourcesGUIs.erase(resourcesGUI)
	sort_GUI()

func sort_GUI() -> void:
	xResourceGUI = 50
	yResourceGUI = 500
	xConstructionGUI = 50
	yConstructionGUI = 200
	for resourcesGUI in resourcesGUIs:
		resourcesGUI.position.x = xResourceGUI
		resourcesGUI.position.y = yResourceGUI
		xResourceGUI += 50
		if xResourceGUI > 200:
			xResourceGUI = 50
			yResourceGUI += 50
	for constructionsGUI in constructionsGUIs:
		constructionsGUI.position.x = xConstructionGUI
		constructionsGUI.position.y = yConstructionGUI
		xConstructionGUI += 50
		if xConstructionGUI > 200:
			xConstructionGUI = 50
			yConstructionGUI += 50

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
