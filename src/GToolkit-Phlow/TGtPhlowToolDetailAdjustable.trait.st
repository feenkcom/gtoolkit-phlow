"
I am a {{gtClass:Trait}}.
I implement a common code to set a {{gtMethod:GtPhlowToolAbstractDetailModel>>#level|label=#selector}}  of information detail which is:
- a {{gtClass:GtPhlowToolDetailState}}'s {{gtMethod:GtPhlowToolDetailState>>#level|label=#selector}} value,
- a value that defines how a {{gtClass:BlElement}} (a tool) should be displayed, e.g., showing all information, and minimum information.
# Common Methods
There are three predefined methods that can be used to define the level:
- {{gtMethod:TGtPhlowToolDetailAdjustable>>#beNormalLevel|label=#selector}},
- {{gtMethod:TGtPhlowToolDetailAdjustable>>#beDetailedLevel|label=#selector}},
- {{gtMethod:TGtPhlowToolDetailAdjustable>>#beCustomLevel:|label=#selector}}.

# Details
See {{gtClass:GtPhlowToolAbstractDetailModel}} for more details.
"
Trait {
	#name : #TGtPhlowToolDetailAdjustable,
	#category : #'GToolkit-Phlow-Tool - Support'
}

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beCustomLevel: aSymbol [
	self dispatchEvent: (GtPhlowToolDetailWish beLevel: aSymbol)
]

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beDetailedLevel [
	self dispatchEvent: GtPhlowToolDetailWish beDetailedLevel
]

{ #category : #'api - tool information detail level adjustable' }
TGtPhlowToolDetailAdjustable >> beNormalLevel [
	self dispatchEvent: GtPhlowToolDetailWish beNormalLevel
]
