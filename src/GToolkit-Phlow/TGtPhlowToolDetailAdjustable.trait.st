Trait {
	#name : #TGtPhlowToolDetailAdjustable,
	#category : #'GToolkit-Phlow-Tool - Support'
}

{ #category : #'api - tool detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beDetailedLevel [
	self dispatchEvent: GtPhlowToolDetailWish beDetailedLevel
]

{ #category : #'api - tool detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beNormalLevel [
	self dispatchEvent: GtPhlowToolDetailWish beNormalLevel
]
