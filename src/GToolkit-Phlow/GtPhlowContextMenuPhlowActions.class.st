Class {
	#name : #GtPhlowContextMenuPhlowActions,
	#superclass : #GtPhlowContextMenuAction,
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #private }
GtPhlowContextMenuPhlowActions >> convertToMenuItem: anObject hostElement: anElement [
	"Utility method to keep the object backward compatible with previous API,
	which was returning `label -> action` associations."

	<return: #BrMenuItem>
	(anObject isKindOf: Association) ifTrue: [
		^ BrMenuActionItem new
			label: anObject key;
			action: anObject value ].

	(anObject isKindOf: BrMenuItem) ifTrue: [
		^ anObject ].
	
	^ anObject asMenuItemWithHostElement: anElement
]

{ #category : #converting }
GtPhlowContextMenuPhlowActions >> toActionOn: anItem index: anItemIndex element: anElement [
	^ self action 
			cull: GtPhlowAction noAction
			cull: anElement 
			cull: anItem 
			cull: anItemIndex
]

{ #category : #converting }
GtPhlowContextMenuPhlowActions >> toMenuItemOn: anItem index: anItemIndex element: anElement [
	<return: #Collection of: #BrMenuItem>
	<return: #BrMenuItems>
	| aResult |
	aResult := self toActionOn: anItem index: anItemIndex element: anElement.
	(aResult isKindOf: BrMenuItems) ifTrue: [ ^ aResult ].

	^ aResult asCollection
		collect: [ :eachAction | 
			self convertToMenuItem: eachAction hostElement: anElement ]
]
