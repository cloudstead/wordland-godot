extends Node

var api_login = HTTPRequest.new()

static func base_uri():
	return "http://127.0.0.1:9091/api/"

static func use_ssl():
	return false

static func api_request_headers():
	return ["Content-Type: application/json"]

func get (http, uri):
	return http.request(str(base_uri(), uri), null, use_ssl())

func post (http, uri, data):
	return http.request(str(base_uri(), uri), api_request_headers(), use_ssl(), HTTPClient.METHOD_POST, JSON.print(data))
	
func put (http, uri, data):
	return http.request(str(base_uri(), uri), api_request_headers(), use_ssl(), HTTPClient.METHOD_PUT, JSON.print(data))

func delete (http, uri):
	return http.request(str(base_uri(), uri), api_request_headers(), use_ssl(), HTTPClient.METHOD_DELETE)

func _ready():
	api_login.connect("request_completed", self, "login_response")

func login (name = null, password = null):
	var uri = str(base_uri(), "auth/login")
	var err = post(api_login, uri, { name: name, password: password })
	print(err)
	return err

func login_response(result, response_code, headers, body):
	print(str("login_response: returned HTTP status ", response_code, " with JSON=", body))
