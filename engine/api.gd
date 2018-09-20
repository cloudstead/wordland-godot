extends Node

static func base_uri():
	return "http://127.0.0.1:9091/api/"

static func use_ssl():
	return false

static func api_request_headers():
	return ["Content-Type: application/json"]

static func get (http, uri):
	return http.request(str(base_uri(), uri), null, use_ssl())

static func post (http, uri, data):
	var err = http.request(str(base_uri(), uri), api_request_headers(), use_ssl(), HTTPClient.METHOD_POST, JSON.print(data))
	print (err)
	return err
	
static func put (http, uri, data):
	return http.request(str(base_uri(), uri), api_request_headers(), use_ssl(), HTTPClient.METHOD_PUT, JSON.print(data))

static func delete (http, uri):
	return http.request(str(base_uri(), uri), api_request_headers(), use_ssl(), HTTPClient.METHOD_DELETE)
