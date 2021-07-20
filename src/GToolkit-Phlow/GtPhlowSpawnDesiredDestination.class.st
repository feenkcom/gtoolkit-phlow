"
I indicate where a {{gtClass:GtPhlowObjectToSpawn}} event show the corresponding tool.

My subclasses indicate the concrete destinations:
- next pane: {{gtClass:GtPhlowSpawnBelowDestination}}
- open below: {{gtClass:GtPhlowSpawnNextPaneDestination}}

Relevant API metods:
- {{gtMethod:GtPhlowSpawnDesiredDestination>>#followingDestination}}
- {{gtMethod:GtPhlowSpawnDesiredDestination>>#icon}}

The default destination is given by {{gtMethod:GtPhlowSpawnDesiredDestination class>>#defaultDestination}}


"
Class {
	#name : 'GtPhlowSpawnDesiredDestination',
	#superclass : 'Object',
	#category : 'GToolkit-Phlow-Direction'
}

{ #category : 'initialization' }
GtPhlowSpawnDesiredDestination class >> defaultDestination [
	^ GtPhlowSpawnNextPaneDestination new
]

{ #category : 'accessing' }
GtPhlowSpawnDesiredDestination >> followingDestination [
	"The destination that comes after this one. It is used to when 
	switching destinations to determine the next destination."
	
	^ self subclassResponsibility
]

{ #category : 'accessing' }
GtPhlowSpawnDesiredDestination >> icon [
	"An icon that to visually indicate the destination. Used in tools to indicate
	this direction to users."
	
	^ self subclassResponsibility 
]

{ #category : 'testing' }
GtPhlowSpawnDesiredDestination >> isSpawnBelow [
	^ false
]

{ #category : 'testing' }
GtPhlowSpawnDesiredDestination >> isSpawnNextPane [
	^ false
]
