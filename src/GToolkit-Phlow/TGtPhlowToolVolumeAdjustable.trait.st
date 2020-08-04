Trait {
	#name : #TGtPhlowToolVolumeAdjustable,
	#category : #'GToolkit-Phlow-Tool - Support'
}

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolVolumeAdjustable >> beDetailedTool [
	self dispatchEvent: GtPhlowToolVolumeWish beDetailedTool
]

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolVolumeAdjustable >> beNormalTool [
	self dispatchEvent: GtPhlowToolVolumeWish beNormalTool
]
