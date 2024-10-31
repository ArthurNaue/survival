extends Node2D

var money := 0

enum materialType {
	wood,
	stone,
	iron
}

enum operation {
	add,
	sub
}

var resources := {
	materialType.wood: 0,
	materialType.stone: 0,
	materialType.iron: 0
}

func update_resources(item: ItemStats, currentOperation: int):
	if currentOperation == operation.sub:
		resources[item.type] -= item.amount
	else:
		resources[item.type] += item.amount

func check_resources(item: ItemStats) -> bool:
	var returnValue := false
	if resources[item.type] > 0:
		returnValue = true
	return returnValue
