extends Area2D

func _ready():
	connect("body_entered", self, "pickup_key")

func pickup_key(body):
	if body.name == "player" && body.get("keys") < 9:
		body.keys += 1
		queue_free()