Class {
	#name : #GtPhlowObjectToSpawn,
	#superclass : #GtPhlowObjectEvent,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #'api - factory' }
GtPhlowObjectToSpawn class >> fromPreviousSpawnEvent: aSpawnEvent [
	^ self new fromPreviousSpawnEvent: aSpawnEvent
]

{ #category : #accessing }
GtPhlowObjectToSpawn >> consumed: aBoolean [
	super consumed: aBoolean.
	self previousSpawnEvent ifNotNil: [ :anEvent | anEvent consumed: aBoolean ]
]

{ #category : #'api - initialization' }
GtPhlowObjectToSpawn >> fromPreviousSpawnEvent: aSpawnEvent [
	self
		previousSpawnEvent: aSpawnEvent;
		tool: aSpawnEvent tool;
		sourceElement: aSpawnEvent currentTarget;
		spawnDestination: aSpawnEvent spawnDestination.
	aSpawnEvent properties keysAndValuesDo: [ :aKey :aValue | 
		self propertyAt: aKey put: aValue ]
]

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

{ #category : #sending }
GtPhlowObjectToSpawn >> sendTo: anObject [
	anObject objectToSpawnEvent: self
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
