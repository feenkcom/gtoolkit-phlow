Class {
	#name : #GtPhlowToolInParentUpdater,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - event managing' }
GtPhlowToolInParentUpdater >> onCompositeUpdateWish: aWish [
	| anElement aToolElement aSelectionState |
	anElement := aWish currentTarget.
	(anElement isKindOf: BlElement) ifTrue: [ 
		aSelectionState := GtPhlowToolSelectionStateHandler new.
		aSelectionState storeSelectionStateFrom: anElement ].

	aToolElement := self onUpdateWish: aWish.
	
	aSelectionState ifNil: [ ^ self ].
	aToolElement ifNil: [ ^ self ].
	aSelectionState applySelectionStateTo: aToolElement
]

{ #category : #'api - event managing' }
GtPhlowToolInParentUpdater >> onUpdateWish: aWish [
	| anElement aPhlowTool aParent |
	anElement := aWish currentTarget.
	(anElement isKindOf: BlElement) ifFalse: [ ^ nil ].
	anElement phlow isTool ifFalse: [ ^ nil ].
	anElement hasParent ifFalse: [ ^ nil ].
	aParent := anElement parent.
	aPhlowTool := anElement phlow entity.
	aPhlowTool asToolElementDo: [ :aToolElement | 
		aParent replaceChild: anElement with: aToolElement as: anElement id.
		BrWidgetPermanentlyRemovedEvent notifyWithAllChildren: anElement.
		^ aToolElement ].
		
	^ nil
]
