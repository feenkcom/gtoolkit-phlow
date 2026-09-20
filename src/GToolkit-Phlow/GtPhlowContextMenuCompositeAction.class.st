Class {
	#name : #GtPhlowContextMenuCompositeAction,
	#superclass : #GtPhlowContextMenuBasicAction,
	#instVars : [
		'showCondition'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #testing }
GtPhlowContextMenuCompositeAction class >> isAbstract [
	^ self name = #GtPhlowContextMenuCompositeAction
]

{ #category : #private }
GtPhlowContextMenuCompositeAction >> convertToMenuItem: anObject hostElement: anElement item: anItem index: anItemIndex [
	"Utility method to keep the object backward compatible with previous API,
	which was returning `label -> action` associations."

	<return: #BrMenuItem>
	(anObject isKindOf: Association) ifTrue: [
		^ BrMenuActionItem new
			label: anObject key;
			action: anObject value ].

	(anObject isKindOf: BrMenuItem) ifTrue: [
		^ anObject ].
	
	^ anObject toMenuItemOn: anItem index: anItemIndex  element: anElement
]

{ #category : #'api - scripting' }
GtPhlowContextMenuCompositeAction >> showIf: aBlock [ 
	showCondition := aBlock
]
