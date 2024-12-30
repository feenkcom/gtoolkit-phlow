Extension { #name : #BrMenuPinnableAptitude }

{ #category : #'*GToolkit-Phlow' }
BrMenuPinnableAptitude >> withPhlowSpawnEventHandler [
	<postPinAction>
	self addEventHandler: GtPhlowMenuSpawnEventHandler new
]
