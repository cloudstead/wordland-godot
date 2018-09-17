extends "res://pickups/pickup.gd"

func do_pickup(body):
	if body.name == "player" && body.health < body.MAX_HEALTH:
		body.health = min(body.health+1, body.MAX_HEALTH)
		queue_free()
