extends Area2D

onready var apiSession = api.session(self)

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.TYPE == "PLAYER":
			if apiSession.session == null:
				$LoginApi.login()
			else:
				print("already logged in")
