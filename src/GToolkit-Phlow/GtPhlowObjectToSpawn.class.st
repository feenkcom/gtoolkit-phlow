Class {
	#name : #GtPhlowObjectToSpawn,
	#superclass : #GtPhlowObjectEvent,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> previousSpawnEvent [
	^ self propertyAt: #previousSpawnEvent ifAbsent: [ nil ]
]

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> previousSpawnEvent: aSpawnEvent [
	self assert: [ aSpawnEvent notNil ].
	
	^ self 
		propertyAt: #previousSpawnEvent 
		put: aSpawnEvent
]

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> spawnDestination [
	^ self 
		propertyAt: #spawnDestination 
		ifAbsent: [ GtPhlowSpawnDesiredDestination defaultDestination ]
]

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> spawnDestination: aSpawnDestination [
	self assert: [ aSpawnDestination notNil ].
	
	self 
		propertyAt: #spawnDestination 
		put: aSpawnDestination
]
