extends "res://wordland/api/ApiBase.gd"

func _ready():
	api_init(self)

func login (name = null, password = null):
	return api.post(self, "auth/login", { "name": name, "password": password })

func handle_api_response (session):
	print("logged in: apiToken={apiToken}".format({ "apiToken": session.apiToken }))
	apiSession.session = session

