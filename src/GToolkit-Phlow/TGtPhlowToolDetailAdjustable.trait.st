Trait {
	#name : #TGtPhlowToolDetailAdjustable,
	#category : #'GToolkit-Phlow-Tool - Support'
}

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolDetailAdjustable >> beDetailedTool [
	self dispatchEvent: GtPhlowToolDetailWish beDetailedTool
]

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolDetailAdjustable >> beNormalTool [
	self dispatchEvent: GtPhlowToolDetailWish beNormalTool
]
