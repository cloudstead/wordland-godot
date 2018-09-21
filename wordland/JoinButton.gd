extends Area2D

var joined = false

func _ready():
	$JoinApi.api_init(self)

func handle_api_response (room):
	print("joined room: room={room}".format({ "room": JSON.print(room) }))

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.TYPE == "PLAYER" and not joined:
				$JoinApi.join("tictac")
				joined = true
