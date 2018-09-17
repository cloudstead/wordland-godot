extends KinematicBody2D

const MAX_HEALTH = 1
const TYPE = "ENEMY"
const DAMAGE = 0.25
const SPEED = 0
const KNOCK_SPEED = 125

const HEART_SCENE = preload("res://pickups/heart.tscn")
const DEATH_SCENE = preload("res://enemies/enemy_death.tscn")

var movedir = dir.CENTER
var knockdir = dir.CENTER
var spritedir = "down"
var hitstun = 0
var health = MAX_HEALTH
var textures = {
	"default": null,
	"hurt": null
}

func _ready():
	textures.default = $Sprite.texture
	textures.hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))

func entity_loop():
	movement_loop()
	damage_loop()

func speed():
	return SPEED

func anim_switch(action):
	var newanim = str(action, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func spritedir_loop():
	if dir.MOVE_MAP.has(movedir):
		var newdir = dir.MOVE_MAP[movedir]
		if newdir != null:
			spritedir = newdir

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * speed()
	else:
		motion = knockdir.normalized() * KNOCK_SPEED
	move_and_slide(motion, dir.FLOOR)

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = textures.hurt
	else:
		if TYPE == "ENEMY" and health <= 0:
			var drop = randi() % 4
			if drop != 0:
				instance_scene(HEART_SCENE)
			instance_scene(DEATH_SCENE)
			queue_free()
		else:
			$Sprite.texture = textures.default

	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() < newitem.maxAmount:
		newitem.add_to_group(str(newitem.get_name(), self))
		add_child(newitem)
	else:
		newitem.queue_free()

func instance_scene(scene):
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().add_child(new_scene)

