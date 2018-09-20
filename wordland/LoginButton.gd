extends Area2D

var state = null

func _ready():
	$LoginApi.set_callback(self, "login_returned")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.TYPE == "PLAYER":
			if state == null:
				state = "logging in"
				$LoginApi.login()

func login_returned (result, status, headers, body):
	print(str("woo hoo ", body.get_string_from_utf8()))
	state = "logged in"
