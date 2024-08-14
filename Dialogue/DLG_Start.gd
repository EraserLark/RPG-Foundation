extends Step
class_name DLG_Start

@export var roomScene: PackedScene: set = recieveRoomScene
#List of actors that will be performing in this scene
@export var requiredActors: Array[String]#: set = setRequiredActors
@export var focusDestination: Step

var timeline: Array

func _enter_tree():
	examineSceneContents(roomScene)
	
	if(requiredActors.size() > 0):
		timeline = Helper.getAllChildren(self)
		self.availableActors = requiredActors

func examineSceneContents(scene: PackedScene):
	if(scene == null):
		return
	
	var sceneState = scene.get_state()
	var nodeCount = sceneState.get_node_count()
	for node in nodeCount:
		print_rich(sceneState.get_node_name(node))

func recieveRoomScene(scene: PackedScene):
	roomScene = scene
	examineSceneContents(roomScene)

func runStep():
	for actorName in requiredActors:
		for actor in DialogueSystem.world.currentRoom.castList.get_children():
			if actor.name == actorName:
				dialogueManager.performingCast[actorName] = actor	#Add actor to dictionary
				break
			else:	#(If cannot find actor)
				var npc = NPC_Database.createNPC(actorName, DialogueSystem.world.currentRoom.castList)
				npc.position = Vector2(800,300)
				dialogueManager.performingCast[actorName] = npc		#Add actor to dictionary
				break
	
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
