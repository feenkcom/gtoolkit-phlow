Extension { #name : #BrWithExplicitPopoverAptitude }

{ #category : #'*GToolkit-Phlow' }
BrWithExplicitPopoverAptitude >> withPhlowSpawnEventHandler [
	<menuContainerInitialization>
	self menuContainer 
		when: GtPhlowObjectToSpawn 
		do: [ :anEvent | 
			anEvent isConsumed ifFalse: [
				self widgetDo: [ :aWidget | 
					aWidget phlow spawnPreviousEvent: anEvent ] ] ]
]

{ #category : #'*GToolkit-Phlow' }
BrWithExplicitPopoverAptitude >> withPhlowUpdateWishEventHandler [
	<menuContainerInitialization>
	self menuContainer
		when: GtPhlowToolUpdateWish
		do: [ :anEvent | 
			anEvent isConsumed
				ifFalse: [ self
						widgetDo: [ :aWidget | 
							| aForwardedEvent |
							aForwardedEvent := GtPhlowToolUpdateWish new.
							aWidget fireEvent: aForwardedEvent.
							aForwardedEvent isConsumed ifTrue: [ anEvent consumed: true ] ] ] ].

	self menuContainer
		when: GtPhlowViewUpdateWish
		do: [ :anEvent | 
			anEvent isConsumed
				ifFalse: [ self
						widgetDo: [ :aWidget | 
							| aForwardedEvent |
							aForwardedEvent := GtPhlowViewUpdateWish new.
							aWidget fireEvent: aForwardedEvent.
							aForwardedEvent isConsumed ifTrue: [ anEvent consumed: true ] ] ] ]
]
