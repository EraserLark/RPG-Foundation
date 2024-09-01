@tool
extends Step
class_name DLG_Start

@export var roomResource: RoomData: set = parseRoomResource
#List of actors that will be performing in this scene
var requiredActors: Array[String]#: set = setRequiredActors
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
	
	availableActors = roomResource.castList
	timeline = Helper.getAllChildren(self)
	
	if(availableActors.size() > 0):
		for step in timeline:
			if(step is Step):
				step.availableActors = requiredActors
	
	if(roomResource.cutsceneMarks.size() > 0):
		for step in timeline:
			if(step is DLG_Walk):
				step.cutscenePathOptions.clear()
				step.cutsceneMarkOptions.clear()
				for mark in roomResource.cutsceneMarks:
					if mark[0] == 'P':	#If mark name starts with P
						step.cutscenePathOptions.append(mark)
					else:
						step.cutsceneMarkOptions.append(mark)
	
	else:
		printerr("No actors in Room Data")

func runStep():
	var currentRoom = DialogueSystem.world.currentRoom
	var castList: Array = currentRoom.castList.get_children()
	var castNames: Array[String]
	for member in castList:
		castNames.append(member.name)
	
	var timeline = Helper.getAllChildren(self)
	for step in timeline:
		if step is DLG_Text or step is DLG_Choice:
			if requiredActors.has(step.messageSpeaker):
				break
			else:
				requiredActors.append(step.messageSpeaker)
		elif step is DLG_SetFlags:
			if requiredActors.has(step.member):
				break
			else:
				requiredActors.append(step.member)
		elif step is DLG_Walk:
			if requiredActors.has(step.actor):
				break
			else:
				requiredActors.append(step.actor)
	
	##CAST LIST
	for actorName in requiredActors:
		if castNames.has(actorName):
			var index = castNames.find(actorName)
			var performingActor = castList[index]
			dialogueManager.performingCast[actorName] = performingActor	#Add actor to dictionary
			#Disable required actors interact areas. Signal reverses this once timeline finished
			performingActor.interactCollider.disabled = true
			dialogueManager.timelineComplete.connect(performingActor.timelineFinished)
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
