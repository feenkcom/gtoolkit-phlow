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

{ #category : #'*GToolkit-Phlow' }
BrWithExplicitMenuAptitude >> withPhlowUpdateWishEventHandler [
	<menuContainerInitialization>
	self menuContainer 
		when: BrPhlowToolUpdateWish 
		do: [ :anEvent | 
			anEvent isConsumed ifFalse: [
				self widgetDo: [ :aWidget | 
					| aForwardedEvent |
					aForwardedEvent := BrPhlowToolUpdateWish new.
					aWidget fireEvent: aForwardedEvent.
					aForwardedEvent isConsumed ifTrue: [
						anEvent consumed: true ] ] ] ]
]
