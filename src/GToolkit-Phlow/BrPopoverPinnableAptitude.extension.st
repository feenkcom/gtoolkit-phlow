Extension { #name : #BrPopoverPinnableAptitude }

{ #category : #'*GToolkit-Phlow' }
BrPopoverPinnableAptitude >> withPhlowSpawnEventHandler [
	<menuPinAction>
	self addPinningAction: (BrMenuPinAction new
		preEndPinBlock: [ self addEventHandler: GtPhlowMenuSpawnEventHandler new ])
]
