Class {
	#name : #GtPhlowContextMenuActions,
	#superclass : #GtPhlowContextMenuAction,
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #private }
GtPhlowContextMenuActions >> convertToMenuItem: anObject [
	"Utility method to keep the object backward compatible with previous API,
	which was returning `label -> action` associations."

	<return: #BrMenuItem>
	(anObject isKindOf: Association) ifTrue: [
		^ BrMenuActionItem new
			label: anObject key;
			action: anObject value ].

	(anObject isKindOf: BrMenuItem) ifTrue: [
		^ anObject ].

	self error: 'Cannot convert to a menu item: ' , anObject printString
]

{ #category : #converting }
GtPhlowContextMenuActions >> toActionOn: anItem [
	^ self action cull: anItem
]

{ #category : #converting }
GtPhlowContextMenuActions >> toMenuItemOn: anItem [
	<return: #Collection of: #BrMenuItem>
	| aResult |
	aResult := self toActionOn: anItem.
	^ aResult asCollection collect: [ :eachAssoc |
		self convertToMenuItem: eachAssoc ]
]
