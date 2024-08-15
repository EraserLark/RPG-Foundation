@tool
extends Step
class_name DLG_Start

@export var roomResource: RoomData: set = parseRoomResource
#List of actors that will be performing in this scene
@export var requiredActors: Array[String]#: set = setRequiredActors
@export var focusDestination: Step
@export var camStartPosition: Vector2
var timeline: Array

func _enter_tree():
	setRoomVars()

func parseRoomResource(resource: RoomData):
	roomResource = resource
	setRoomVars()

func setRoomVars():
	if roomResource == null:
		return
	
	requiredActors = roomResource.castList
	
	if(requiredActors.size() > 0):
		timeline = Helper.getAllChildren(self)
		self.availableActors = requiredActors
		for step in timeline:
			if(step is Step):
				step.availableActors = requiredActors
	else:
		printerr("No actors in Room Data")

func runStep():
	var castList: Array = DialogueSystem.world.currentRoom.castList.get_children()
	var castNames: Array[String]
	for member in castList:
		castNames.append(member.name)
	print(castNames)
	
	for actorName in requiredActors:
		if castNames.has(actorName):
			var index = castNames.find(actorName)
			dialogueManager.performingCast[actorName] = castList[index]	#Add actor to dictionary
			break
		else:
			var npc = NPC_Database.createNPC(actorName, DialogueSystem.world.currentRoom.castList)
			npc.position = Vector2(800,300)
			dialogueManager.performingCast[actorName] = npc		#Add actor to dictionary
	
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
