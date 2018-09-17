extends Node

export var disappears = false

func _ready():
	connect("body_entered", self, "do_pickup")
	connect("area_entered", self, "area_pickup")

func do_pickup(body):
	body.do_pickup()
	
func area_pickup(area):
	var area_parent = area.get_parent()
	if area_parent.name == "sword":
		do_pickup(area_parent.get_parent())
