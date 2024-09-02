#extends OW_Actor
extends CharacterBody2D
class_name OW_Player

##Child references
@onready var animTree:= $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var animPlayer:= $AnimationPlayer
@onready var interactRay:= $"RayCast2D"
@onready var danceTimer:= $DanceTimer
@onready var collisionShape:= $CollisionShape2D

##Parent references
#var owManager: OverworldManager
var playerEntity: OWEntity_Player
var currentRoom: Room

##Export vars
@export var speed:= 500
#@export var playerInfo: PlayerInfo
@export var stepCount: int
@export var encounterThreshold: int

##Non export vars
var currentDir: Vector2
var dirChangeCount:= 0
var rayLength := 32

##Initialization
func _ready():
	print("Player Ready Start")
	print("Player Ready Finish")

func initialize(pe: OWEntity_Player, rm: Room):
	#owManager = om
	playerEntity = pe
	currentRoom = rm
	
	resetEncounterThreshold()

func getPlayerNum():
	return playerEntity.rosterNumber

#func setPlayerInfo(pi: PlayerInfo):
	#playerInfo = pi

##Movement
func moveDirection(dir: Vector2):
	##Play walk animation?
	self.velocity = dir.normalized() * speed;
	if(dir != Vector2.ZERO):
		stepCounter()

##Called in Player_Active state so it can't run once state changes
func physicsUpdate(delta: float):
	move_and_slide()

func stepCounter():
	stepCount += 1
	print(str("Steps: ", stepCount))
	if(stepCount >= encounterThreshold):
		stepCount = 0
		resetEncounterThreshold()
		
		var enterBattleState = Player_EnterBattle.new(GameStateStack.stack)
		GameStateStack.stack.addState(enterBattleState, {"Room": currentRoom})
		#currentRoom.startBattle()

func resetEncounterThreshold():
	encounterThreshold = randi_range(1500, 3000)
	print(str("Encounter Threshold: ", encounterThreshold))

func faceDirection(dir: Vector2) -> bool:
	interactRay.target_position = dir * rayLength;
	animTree.set("parameters/Idle/blend_position", dir)
	animTree.set("parameters/Walk/blend_position", dir)
	#animState.travel("Idle")
	
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
	var spawnPos
	var rayCast = RayCast2D.new()
	self.add_child(rayCast)
	
	#rayCast.target_position = Vector2(32, 0)
	#Check behind player first
	rayCast.target_position = -currentDir * 32
	if !rayCast.get_collider():
		var posNode = Node2D.new()
		add_child(posNode)
		posNode.position = rayCast.target_position
		spawnPos = posNode.global_position
	else:
		#Check front
		rayCast.target_position = currentDir * 32#Check front
		if !rayCast.get_collider():
			var posNode = Node2D.new()
			add_child(posNode)
			posNode.position = rayCast.target_position
			spawnPos = posNode.global_position
		else:
			spawnPos = Vector2.ZERO
	
	return spawnPos

##Interaction
func openMenu():
	var manualmenuState = ManualMenu_State.new(playerEntity.playerStateStack, playerEntity.input, playerEntity.entityUI.playerPanel)
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
	#StateStack.removeState()
