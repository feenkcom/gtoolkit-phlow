Class {
	#name : #GtPhlowContextMenuItemBoundAction,
	#superclass : #Object,
	#instVars : [
		'targetAction',
		'item',
		'viewSelection'
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
		id: self targetAction id;
		label: self targetAction label;
		tooltipText: self targetAction tooltipText;
		iconStencil: self targetAction iconStencil;
		phlowDataSource: (GtRemotePhlowContextMenuItemBoundActionDataSource new
			phlowAction: self)
]

{ #category : #actions }
GtPhlowContextMenuItemBoundAction >> executeActionFrom: anElement [
	^ self actionComputation
			cull: anElement cull: item cull: viewSelection
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
GtPhlowContextMenuItemBoundAction >> targetAction [
	^ targetAction
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> targetAction: anObject [
	targetAction := anObject
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> viewSelection [
	^ viewSelection
]

{ #category : #accessing }
GtPhlowContextMenuItemBoundAction >> viewSelection: anObject [
	viewSelection := anObject
]
