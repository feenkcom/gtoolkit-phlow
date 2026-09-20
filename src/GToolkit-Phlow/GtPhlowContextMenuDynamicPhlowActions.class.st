Class {
	#name : #GtPhlowContextMenuDynamicPhlowActions,
	#superclass : #GtPhlowContextMenuCompositeAction,
	#instVars : [
		'label',
		'actionsComputation'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #'instance creation' }
GtPhlowContextMenuDynamicPhlowActions class >> label: aLabel actions: aBlockClosure [
	^ self new 
		label: 'Dynamic phlow menu items';
		actions: aBlockClosure 
]

{ #category : #'api - scripting' }
GtPhlowContextMenuDynamicPhlowActions >> actions: aBlockClosure [
	actionsComputation := aBlockClosure
]

{ #category : #accessing }
GtPhlowContextMenuDynamicPhlowActions >> actionsComputation [
	^ actionsComputation
]

{ #category : #converting }
GtPhlowContextMenuDynamicPhlowActions >> collectInvidualActionsOn: aCollection forElement: anElement item: anObject index: anIndex [
	aCollection addAll: (self actionsComputation 
		cull: GtRemotePhlowAction noAction
		cull: anElement 
		cull: anObject 
		cull: anIndex )
]

{ #category : #accessing }
GtPhlowContextMenuDynamicPhlowActions >> label [
	^ label
]

{ #category : #'api - scripting' }
GtPhlowContextMenuDynamicPhlowActions >> label: aString [ 
	label := aString
]

{ #category : #converting }
GtPhlowContextMenuDynamicPhlowActions >> toActionOn: anItem index: anItemIndex element: anElement [
	^ self actionsComputation 
			cull: GtPhlowAction noAction
			cull: anElement 
			cull: anItem 
			cull: anItemIndex
]

{ #category : #converting }
GtPhlowContextMenuDynamicPhlowActions >> toMenuItemOn: anItem index: anItemIndex element: anElement [
	<return: #Collection of: #BrMenuItem>
	<return: #BrMenuItems>
	| aResult |
	aResult := self toActionOn: anItem index: anItemIndex element: anElement.
	(aResult isKindOf: BrMenuItems) ifTrue: [ ^ aResult ].

	^ aResult asCollection
		collect: [ :eachAction | 
			self 
				convertToMenuItem: eachAction 
				hostElement: anElement
				item: anItem 
				index: anItemIndex ]
]
