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
