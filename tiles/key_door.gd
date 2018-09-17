extends StaticBody2D

func _ready():
	$area.connect("body_entered", self, "try_unlock_door")

func try_unlock_door(body):
	if body.name == "player" && body.keys > 0:
		body.keys -= 1
		queue_free()