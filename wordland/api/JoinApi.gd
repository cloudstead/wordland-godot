extends "res://wordland/api/ApiBase.gd"

func join (room = null):
	return api.post(self, "rooms/{room}/join".format({"room": room}), {})
