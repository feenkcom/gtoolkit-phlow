Class {
	#name : #GtPhlowContextMenuBasicAction,
	#superclass : #Object,
	#instVars : [
		'filter',
		'showCondition'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #testing }
GtPhlowContextMenuBasicAction class >> isAbstract [
	^ self name = #GtPhlowContextMenuBasicAction
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> collectInvidualActionsOn: aCollection forElement: anElement item: anObject index: anIndex [
	self subclassResponsibility
]

{ #category : #accessing }
GtPhlowContextMenuBasicAction >> filter [

	^ filter
]

{ #category : #accessing }
GtPhlowContextMenuBasicAction >> filter: anObject [

	filter := anObject
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> respondsToItem: anItem [
	"Kept for backward compatibility. To be removed"
	^ self filter ifNil: [ true ] ifNotNil: [ :aFilter | aFilter value: anItem ]
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> shouldShowContextActionOn: anItem index: aSelectionIndex [ 
	self filter ifNotNil: [ 
		"For backwards compatibility"
		^ self respondsToItem: anItem ].
		
	^ self showCondition 
		ifNil: [ true ] 
		ifNotNil: [ :aShowConditon |
			aShowConditon cull: anItem cull: aSelectionIndex ]
]

{ #category : #accessing }
GtPhlowContextMenuBasicAction >> showCondition [
	^ showCondition
]

{ #category : #'api - scripting' }
GtPhlowContextMenuBasicAction >> showIf: aBlock [ 
	showCondition := aBlock
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> toMenuItemOn: anItem index: anItemIndex  element: anotherElement [
	self subclassResponsibility
]
