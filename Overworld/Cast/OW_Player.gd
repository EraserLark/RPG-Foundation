extends CharacterBody2D
class_name OW_Player

##Child references
@onready var sprite:= $Sprite2D
@onready var animTree:= $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var animPlayer:= $AnimationPlayer
@onready var interactRay:= $"RayCast2D"
@onready var danceTimer:= $DanceTimer
@onready var collisionShape:= $CollisionShape2D

##Parent references
var playerEntity: PlayerEntity
var currentRoom: Room

##Export vars
@export var speed:= 500
@export var stepCount: int
@export var encounterThreshold: int
@export var highlightColors: Array[Color]

##Non export vars
var currentDir: Vector2
var dirChangeCount:= 0
var rayLength := 32

func _ready():
	pass

func initialize(pe: PlayerEntity, rm: Room):
	playerEntity = pe
	currentRoom = rm
	
	#Set player highlight color
	var highlightColor = highlightColors[playerEntity.rosterNumber]
	sprite.material.set_shader_parameter("newColor", highlightColor)
	
	resetEncounterThreshold()

func getPlayerNum():
	return playerEntity.rosterNumber

##Movement
func moveDirection(dir: Vector2):
	##Play walk animation?
	self.velocity = dir.normalized() * speed;
	if (!DebugManager.get_flag(DebugManager.Flags.DISABLE_ENEMIES)):
		if(!currentRoom.safeRoom):
			if(playerEntity.rosterNumber == 0):
				if(dir != Vector2.ZERO):
					stepCounter()

#Called in Player_Active state so it can't run once state changes
func physicsUpdate(delta: float):
	move_and_slide()
	#self.global_position = round(self.global_position/ 2) * 2

func stepCounter():
	stepCount += 1
	print(str("Steps: ", stepCount))
	if(stepCount >= encounterThreshold):
		stepCount = 0
		resetEncounterThreshold()
		
		var enterBattleState = Player_EnterBattle.new({"Room": currentRoom})

func resetEncounterThreshold():
	encounterThreshold = randi_range(1000, 2000)
	print(str("Encounter Threshold: ", encounterThreshold))

func faceDirection(dir: Vector2) -> bool:
	interactRay.target_position = dir * rayLength;
	animTree.set("parameters/Idle/blend_position", dir)
	animTree.set("parameters/Walk/blend_position", dir)
	
	if(dir != currentDir):
		danceTimer.start()
		dirChangeCount += 1
	currentDir = dir
	
	if(dirChangeCount >= 10):
		var danceState = Player_Dance.new(playerEntity.playerStateStack, self)
		playerEntity.playerStateStack.addState(danceState)
		return true
	return false

func _on_dance_timer_timeout():
	dirChangeCount = 0

func danceFinish():
	playerEntity.playerStateStack.removeState()
	faceDirection(Vector2(0,1))

func scanForSpawn():
	var spawnPos: Vector2
	var rayCast = RayCast2D.new()
	self.add_child(rayCast)
	
	#Check behind player first
	rayCast.target_position = -currentDir * 32
	if !rayCast.get_collider():
		var posNode = Node2D.new()
		add_child(posNode)
		posNode.position = rayCast.target_position
		spawnPos = posNode.global_position
		posNode.queue_free()
	else:
		#Check front
		rayCast.target_position = currentDir * 32
		if !rayCast.get_collider():
			var posNode = Node2D.new()
			add_child(posNode)
			posNode.position = rayCast.target_position
			spawnPos = posNode.global_position
			posNode.queue_free()
		else:
			spawnPos = Vector2.ZERO
	
	rayCast.queue_free()
	return spawnPos

##Interaction
func openMenu():
	var manualmenuState = ManualMenu_State.new(playerEntity.playerStateStack, playerEntity.input, playerEntity.worldUI.playerPanel)
	playerEntity.playerStateStack.addState(manualmenuState)

func castInteractRay():
	var interactee = interactRay.get_collider()
	if(interactee is StaticBody2D):
		interactee = interactee.get_parent()
	interact(interactee)

func interact(interactee: Object):
	if(interactee == null):
		return
	
	interactee.get_parent().interactAction(self)

func addItemToInv(item : Item):
	var player = PlayerRoster.roster[0]
	player.itemList = Helper.append(player.itemList, item)

func endPlayerActor():
	pass
