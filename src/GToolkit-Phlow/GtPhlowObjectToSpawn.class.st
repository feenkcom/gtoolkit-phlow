Class {
	#name : #GtPhlowObjectToSpawn,
	#superclass : #GtPhlowObjectEvent,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> previousSpawnEvent [
	^ self propertyAt: #previousSpawnEvent 
]

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> previousSpawnEvent: aSpawnEvent [
	self assert: [ aSpawnEvent notNil ].
	
	^ self 
		propertyAt: #previousSpawnEvent 
		put: aSpawnEvent
]

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> spawnDirection [
	^ self 
		propertyAt: #spawnDirection 
		ifAbsent: [ GtPhlowSpawnDirection defaultDirection ]
]

{ #category : #'accessing - utils' }
GtPhlowObjectToSpawn >> spawnDirection: aSpawnDirection [
	self assert: [ aSpawnDirection notNil ].
	
	^ self 
		propertyAt: #spawnDirection 
		put: aSpawnDirection
]
