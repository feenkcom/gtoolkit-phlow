"
I am a {{gtClass:Trait}}.
I implement a common code to set a {{gtMethod:GtPhlowToolDetailState>>#level|label=#selector}}  of information detail which is:
- a {{gtClass:GtPhlowToolDetailState}}'s {{gtMethod:GtPhlowToolDetailState>>#level|label=#selector}} value,
- a value that defines how a {{gtClass:BlElement}} (a tool) should be displayed, e.g., showing all information, and minimum information.
# Common Methods
There are three predefined methods that can be used to define the level:
- {{gtMethod:TGtPhlowToolDetailAdjustable>>#beNormalLevel|label=#selector}},
- {{gtMethod:TGtPhlowToolDetailAdjustable>>#beDetailedLevel|label=#selector}},
- {{gtMethod:TGtPhlowToolDetailAdjustable>>#beCustomLevel:|label=#selector}}.

# Details
See {{gtClass:GtPhlowToolDetailState}} for more details.
"
Trait {
	#name : #TGtPhlowToolDetailAdjustable,
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beCustomLevel: aSymbol [
	self beLevelState: (GtPhlowToolDetailState level: aSymbol)
]

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beDetailedLevel [
	self beLevelState: GtPhlowToolDetailState detailed
]

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beLevelState: aGtPhlowToolDetailState [
	self states addState: aGtPhlowToolDetailState
]

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beNormalLevel [
	self beLevelState: GtPhlowToolDetailState normal
]

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> isDetailedLevel [
	^ (GtPhlowToolDetailState getLevelOf: self) = GtPhlowToolDetailState detailed
]
