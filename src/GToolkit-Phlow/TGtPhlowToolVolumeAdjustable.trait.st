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
TGtPhlowToolVolumeAdjustable >> beDetailedLevel [
	self dispatchEvent: GtPhlowToolDetailWish beDetailedLevel
]

{ #category : #'api - tool volume adjustable' }
TGtPhlowToolVolumeAdjustable >> beNormalLevel [
	self dispatchEvent: GtPhlowToolDetailWish beNormalLevel
]
