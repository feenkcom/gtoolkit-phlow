Class {
	#name : #GtPhlowContextMenuDynamicActions,
	#superclass : #GtPhlowContextMenuCompositeAction,
	#instVars : [
		'label',
		'actionsComputation'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #'instance creation' }
GtPhlowContextMenuDynamicActions class >> label: aLabel actions: aBlockClosure [
	^ self new 
		label: 'Dynamic phlow menu items';
		actions: aBlockClosure 
]

{ #category : #'api - scripting' }
GtPhlowContextMenuDynamicActions >> actions: aBlockClosure [
	actionsComputation := aBlockClosure
]

{ #category : #accessing }
GtPhlowContextMenuDynamicActions >> actionsComputation [
	^ actionsComputation
]

{ #category : #converting }
GtPhlowContextMenuDynamicActions >> collectInvidualActionsOn: aCollection forElement: anElement item: anObject index: anIndex [
	| result |
	result := self toActionOn: anObject index: anIndex element: anElement.
	(result isKindOf: BrMenuItems) ifTrue: [ ^ self ].
	
	result do: [ :anAction | 
		((anObject isKindOf: Association) or: [
			(anObject isKindOf: BrMenuItem) ])
				ifFalse: [ aCollection add: anAction ] ] 
]

{ #category : #accessing }
GtPhlowContextMenuDynamicActions >> label [
	^ label
]

{ #category : #'api - scripting' }
GtPhlowContextMenuDynamicActions >> label: aString [ 
	label := aString
]

{ #category : #converting }
GtPhlowContextMenuDynamicActions >> toActionOn: anItem index: anItemIndex element: anElement [
	^ self actionsComputation cull: anElement cull: anItem cull: anItemIndex
]

{ #category : #converting }
GtPhlowContextMenuDynamicActions >> toMenuItemOn: anItem index: anItemIndex element: anElement [
	<return: #Collection of: #BrMenuItem>
	<return: #BrMenuItems>
	| aResult |
	aResult := self toActionOn: anItem index: anItemIndex element: anElement.
	(aResult isKindOf: BrMenuItems) ifTrue: [ ^ aResult ].

	^ aResult collect: [ :eachAssoc | 
			self convertToMenuItem: eachAssoc hostElement: anElement ]
]
