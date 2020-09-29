"
Use ${class:TGtPhlowToolDetailAdjustable}$ instead.
"
Trait {
	#name : #TGtPhlowToolVolumeAdjustable,
	#category : #'GToolkit-Phlow-Tool - Support'
}

{ #category : #testing }
TGtPhlowToolVolumeAdjustable classSide >> isDeprecated [
	^ self name = #TGtPhlowToolVolumeAdjustable
]

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolVolumeAdjustable >> beDetailedTool [
	self dispatchEvent: GtPhlowToolDetailWish beDetailedTool
]

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolVolumeAdjustable >> beNormalTool [
	self dispatchEvent: GtPhlowToolDetailWish beNormalTool
]
