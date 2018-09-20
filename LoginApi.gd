extends HTTPRequest

func set_callback(target, method):
	return connect("request_completed", target, method)

func login (name = null, password = null):
	return api.post(self, "auth/login", { "name": name, "password": password })
