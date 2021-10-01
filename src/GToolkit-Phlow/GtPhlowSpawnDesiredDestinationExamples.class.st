Class {
	#name : #GtPhlowSpawnDesiredDestinationExamples,
	#superclass : #Object,
	#category : 'GToolkit-Phlow-Examples'
}

{ #category : #examples }
GtPhlowSpawnDesiredDestinationExamples >> belowDestination [
	<gtExample>
	| direction |
	direction := GtPhlowSpawnBelowDestination new.
	
	self assert: direction isSpawnBelow.
	self assert: direction followingDestination isSpawnNextPane.
	self assert: direction class defaultDestination isSpawnNextPane.
	
	^ direction
]

{ #category : #examples }
GtPhlowSpawnDesiredDestinationExamples >> nextPaneDestination [
	<gtExample>
	| direction |
	direction := GtPhlowSpawnNextPaneDestination new.
	
	self assert: direction isSpawnNextPane.
	self assert: direction followingDestination isSpawnBelow.
	self assert: direction class defaultDestination isSpawnNextPane.
	
	^ direction
]
