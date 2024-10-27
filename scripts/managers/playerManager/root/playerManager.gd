extends Node2D

var money := 0
var wood := 0
var stone := 0
var iron := 0

var resources: Dictionary

func update_resources(item: ItemStats, operation: String):
	match item.type:
		"wood":
			if operation == "+":
				wood += item.amount
			else:
				wood -= item.amount
		"stone":
			if operation == "+":
				stone += item.amount
			else:
				stone -= item.amount
		"iron":
			if operation == "+":
				iron += item.amount
			else:
				iron -= item.amount
	
	resources = {
		"wood": wood,
		"stone": stone,
		"iron": iron
	}

func check_resources(item: ItemStats) -> bool:
	var returnValue := false
	match item.type:
		"wood":
			if wood > 0:
				returnValue = true
		"stone":
			if stone > 0:
				returnValue = true
		"iron":
			if iron > 0:
				returnValue = true
	return returnValue
