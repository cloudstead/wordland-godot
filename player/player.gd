extends "res://engine/entity.gd"

const TYPE = "PLAYER"
const SPEED = 70
const DAMAGE = 0
const PUSH_SPEED = 40
const MAX_HEALTH = 5

var state = "default"
var keys = 0

func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
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
	
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))

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