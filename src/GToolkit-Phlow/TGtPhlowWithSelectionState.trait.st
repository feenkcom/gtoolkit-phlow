Trait {
	#name : #TGtPhlowWithSelectionState,
	#instVars : [
		'selectionState'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #'api - selection state' }
TGtPhlowWithSelectionState >> selectionState [
	<return: #GtPhlowToolSelectionState or: nil>
	^ selectionState
]

{ #category : #'api - selection state' }
TGtPhlowWithSelectionState >> selectionState: aState [
	selectionState := aState
]

{ #category : #'api - selection state' }
TGtPhlowWithSelectionState >> selectionStateDo: aSelectionStateBlock ifAbsent: anAbsentBlock [
	"If there is an explicitly defined selection state, 
	evaluate aSelectionStateBlock with one parameter [ :aSelectionState | ], 
	otherwise evaluate anAbsentBlock without any parameter."

	^ self selectionState ifNotNil: aSelectionStateBlock ifNil: anAbsentBlock
]

{ #category : #'api - selection state' }
TGtPhlowWithSelectionState >> tabName: aString [
	self toolTabIdentifier: GtPhlowTool default toolTabIdentifier tabName: aString
]

{ #category : #'api - selection state' }
TGtPhlowWithSelectionState >> toolTabIdentifier: aToolTabIdentifier tabName: aString [
	selectionState := GtPhlowTabbedToolSelectionState new
			targetToolIdentifier: aToolTabIdentifier;
			tabIdentifier: (GtPhlowTabName new string: aString asString)
]
