Extension { #name : #BrMenuPinnableAptitude }

{ #category : #'*GToolkit-Phlow' }
BrMenuPinnableAptitude >> withPhlowSpawnEventHandler [
	<menuPinAction>
	self addPinningAction: (BrMenuPinAction new
		preEndPinBlock: [ self addEventHandler: GtPhlowMenuSpawnEventHandler new ])
]
