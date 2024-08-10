extends Step
class_name DLG_Start

#List of actors that will be performing in this scene
@export var requiredActors: Array[String]
@export var focusDestination: Step
@export var camStartPosition: Vector2

#Set to null while testing in isolated scene. Change when implemeting
#func _init(dm: DialogueManager = null):
	#super(dm)

func _ready():
	pass

func runStep():
	##Assert that:
	# all actors exist
		#Scan current room's castList, match which actors there are needed for the interaction
		#if not all actors exist, instantiate the ones needed
	# all actors are in correct positions
		#if not, have them walk to correct positions
	#Camera is in correct position
		#if not, have it move to correct position
	
	##Don't need to worry about:
	# Flags. Timeline is selected based off what flags are/aren't set in FlagManager
	
	##Implementation:
	#Iterate through requiredActors list (array of actor names)
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
			
			#if actor.position != destination:
				#actor.walkTo(destination)
	#Do not move forward until all actors exist and are in their correct spots
	#Move cam to camStartPosition as well
	
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
