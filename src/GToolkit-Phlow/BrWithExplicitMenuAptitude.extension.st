Extension { #name : #BrWithExplicitMenuAptitude }

{ #category : #'*GToolkit-Phlow' }
BrWithExplicitMenuAptitude >> withPhlowSpawnEventHandler [
	<menuContainerInitialization>
	self menuContainer 
		when: GtPhlowObjectToSpawn 
		do: [ :anEvent | 
			anEvent isConsumed ifFalse: [
				self widgetDo: [ :aWidget | 
					aWidget phlow spawnPreviousEvent: anEvent ] ] ]
]
