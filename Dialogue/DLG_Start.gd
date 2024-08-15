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
	timeline = Helper.getAllChildren(self)
	
	if(requiredActors.size() > 0):
		self.availableActors = requiredActors
		for step in timeline:
			if(step is Step):
				step.availableActors = requiredActors
	
	if(roomResource.cutsceneMarks.size() > 0):
		print("1")
		for step in timeline:
			if(step is DLG_Walk):
				print("2")
				for mark in roomResource.cutsceneMarks:
					if mark[0] == 'P':	#If mark name starts with P
						print("P")
						step.cutscenePathOptions.append(mark)
					else:
						print("No P")
						step.cutsceneMarkOptions.append(mark)
	
	else:
		printerr("No actors in Room Data")

func runStep():
	var currentRoom = DialogueSystem.world.currentRoom
	var castList: Array = currentRoom.castList.get_children()
	var castNames: Array[String]
	for member in castList:
		castNames.append(member.name)
	
	##CAST LIST
	for actorName in requiredActors:
		if castNames.has(actorName):
			var index = castNames.find(actorName)
			dialogueManager.performingCast[actorName] = castList[index]	#Add actor to dictionary
			break
		else:
			var npc = NPC_Database.createNPC(actorName, currentRoom.castList)
			npc.position = Vector2(800,300)
			dialogueManager.performingCast[actorName] = npc		#Add actor to dictionary
	
	##CUTSCENE MARKERS
	var cutsceneMarkers: Array = currentRoom.cutsceneMarks.get_children()
	for marker in cutsceneMarkers:
		dialogueManager.cutsceneMarks[marker.name] = marker
	
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
