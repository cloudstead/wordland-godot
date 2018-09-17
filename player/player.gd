extends "res://engine/entity.gd"

const TYPE = "PLAYER"
const SPEED = 70
const DAMAGE = 0
const PUSH_SPEED = 40
const MAX_HEALTH = 5

const SWORD_SCENE = preload("res://items/sword.tscn")

var state = "default"
var saved_state = "default"
var keys = 0
var beast_texture = null

func _ready():
	textures.beast = $Sprite.texture

func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
		"beast":
			state_beast()
	keys = min(keys, 9)

func pushing():
	return is_on_wall() and test_move(transform, dir.REV_MOVE_MAP[spritedir])

func speed():
	if pushing():
		return PUSH_SPEED
	return SPEED

func state_default():
	controls_loop()
	entity_loop()
	spritedir_loop()
	
	if pushing():
		anim_switch("push")
	elif movedir != dir.CENTER:
		anim_switch("walk")
	else:
		anim_switch("idle")
	
	if state != "beast" && Input.is_action_just_pressed("a"):
		use_item(SWORD_SCENE)
	if Input.is_action_just_pressed("b"):
		enable_beast_mode()

func damage():
	if state == "beast":
		return 1000
	return .damage()

func impact_speed():
	if state == "beast":
		return 1200
	return 125

func damage_loop():
	if state == "beast":
		return
	.damage_loop()

func state_beast():
	if beast_texture == null || beast_texture == "default":
		beast_texture = "hurt"
	else:
		beast_texture = "default"
	$Sprite.texture = textures[beast_texture]
	state_default()

func enable_beast_mode():
	timed_state("beast", 10)

func timed_state(new_state, seconds):
	if $specialStateTimer.is_stopped():
		saved_state = state
		state = new_state
		$specialStateTimer.connect("timeout", self, "reset_state")
		$specialStateTimer.start()

func reset_state():
	state = saved_state
	$specialStateTimer.stop()
	$specialStateTimer.disconnect("timeout", self, "reset_state")

func controls_loop():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(left) + int(right)
	movedir.y = -int(up) + int(down)

func state_swing():
	anim_switch("idle")
	entity_loop()
	movedir = dir.CENTER