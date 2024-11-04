extends Node2D

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

var resources := {
	materialType.wood: 0,
	materialType.refinedWood: 0,
	materialType.stone: 0,
	materialType.rawIron: 0,
	materialType.rawGold: 0,
	materialType.gold: 0,
	materialType.iron: 0
}

func update_resources(item: ItemStats, currentOperation: int):
	if currentOperation == operation.sub:
		resources[item.type] -= item.amount
	else:
		resources[item.type] += item.amount

	for resource in get_player().resourcesTexts:
		resource.update_value()

func check_resources(item: ItemStats) -> bool:
	var returnValue := false
	if resources[item.type] > 0:
		returnValue = true
	return returnValue

func get_player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player")
