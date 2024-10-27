extends Node2D

var money := 0
var wood := 0
var rock := 0

var resources: Dictionary

func update_resources(resource: String, amount: int):
	match resource:
		"wood":
			wood += amount
		"rock":
			rock += amount
	
	resources = {
		"wood": wood,
		"rock": rock
	}
