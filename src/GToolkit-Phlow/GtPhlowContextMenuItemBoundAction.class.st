Class {
	#name : #GtPhlowContextMenuItemBoundAction,
	#superclass : #Object,
	#instVars : [
		'targetAction',
		'item',
		'index'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> actionComputation [
	^ targetAction actionComputation
]

{ #category : #converting }
GtPhlowContextMenuItemBoundAction >> asGtDeclarativeAction [
	^ GtRemotePhlowContextMenuItemBoundActionSpecification new
		tooltipText: targetAction tooltipText;
		label: self label;
		iconStencil: targetAction iconStencil;
		phlowDataSource: (GtRemotePhlowContextMenuItemBoundActionDataSource new
			phlowAction: self)
]

{ #category : #actions }
GtPhlowContextMenuItemBoundAction >> executeActionFrom: anElement [
	^ self actionComputation
			cull: anElement cull: item cull: index
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> index [
	^ index
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> index: anObject [
	index := anObject
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> item [
	^ item
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> item: anObject [
	item := anObject
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> label [
	^ targetAction label
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> targetAction [
	^ targetAction
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> targetAction: anObject [
	targetAction := anObject
]
