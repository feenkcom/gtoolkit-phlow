Trait {
	#name : #TGtPhlowToolDetailAdjustable,
	#category : #'GToolkit-Phlow-Tool - Support'
}

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolDetailAdjustable >> beDetailedLevel [
	self dispatchEvent: GtPhlowToolDetailWish beDetailedLevel
]

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolDetailAdjustable >> beNormalLevel [
	self dispatchEvent: GtPhlowToolDetailWish beNormalLevel
]
