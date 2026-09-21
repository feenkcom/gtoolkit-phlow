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
	| collectedActions |
	collectedActions := self toActionOn: anObject index: anIndex element: anElement.
	(collectedActions isKindOf: BrMenuItems) ifTrue: [ ^ self ].
	
	collectedActions do: [ :anAction | 
		((anObject isKindOf: Association) or: [
			(anObject isKindOf: BrMenuItem) ])
				ifFalse: [ 
					(anAction shouldShowContextActionOn: anObject index: anIndex) ifTrue: [
						aCollection add: anAction ] ] ] 
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
GtPhlowContextMenuDynamicActions >> toActionOn: anItem index: anIndexSelection element: anElement [
	^ self actionsComputation cull: anElement cull: anItem cull: anIndexSelection
]

{ #category : #converting }
GtPhlowContextMenuDynamicActions >> toMenuItemOn: anItem index: anIndexSelection element: anElement [
	<return: #Collection of: #BrMenuItem>
	<return: #BrMenuItems>
	| aResult |
	aResult := self toActionOn: anItem index: anIndexSelection element: anElement.
	(aResult isKindOf: BrMenuItems) ifTrue: [ ^ aResult ].

	^ aResult collect: [ :eachAssoc | 
			self 
				convertToMenuItem: eachAssoc 
				hostElement: anElement
				item: anItem 
				index: anIndexSelection ]
]
