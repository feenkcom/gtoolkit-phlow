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
