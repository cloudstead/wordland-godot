extends "res://pickups/pickup.gd"

func do_pickup(body):
	if body.name == "player" && body.get("keys") < 9:
		body.keys += 1
		queue_free()