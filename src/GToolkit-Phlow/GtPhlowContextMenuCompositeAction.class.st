Class {
	#name : #GtPhlowContextMenuCompositeAction,
	#superclass : #GtPhlowContextMenuBasicAction,
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #testing }
GtPhlowContextMenuCompositeAction class >> isAbstract [
	^ self name = #GtPhlowContextMenuCompositeAction
]

{ #category : #converting }
GtPhlowContextMenuCompositeAction >> collectInvidualActionsOn: aCollection forElement: anElement item: anObject index: anIndex [
	| collectedActions |
	collectedActions := self toActionOn: anObject index: anIndex element: anElement.
	(collectedActions isKindOf: BrMenuItems) ifTrue: [ ^ self ].
	
	collectedActions do: [ :anAction | 
		((anObject isKindOf: Association) or: [
			(anObject isKindOf: BrMenuItem) ])
				ifFalse: [ 
					(anAction shouldShowContextActionOn: anObject viewSelection: anIndex) ifTrue: [
						aCollection add: anAction ] ] ] 
]

{ #category : #private }
GtPhlowContextMenuCompositeAction >> convertToMenuItem: anObject hostElement: anElement item: anItem index: anItemIndex [
	"Utility method to keep the object backward compatible with previous API,
	which was returning `label -> action` associations."

	<return: #BrMenuItem>
	(anObject isKindOf: Association) ifTrue: [
		^ BrMenuActionItem new
			label: anObject key;
			action: anObject value ].

	(anObject isKindOf: BrMenuItem) ifTrue: [
		^ anObject ].
	
	^ anObject toMenuItemOn: anItem index: anItemIndex  element: anElement
]

{ #category : #testing }
GtPhlowContextMenuCompositeAction >> shouldShowAction: anAction item: anObject index: anIndex [
	^ (anAction isKindOf: Association) or: [
		(anAction isKindOf: BrMenuItem) or: [
			anAction shouldShowContextActionOn: anObject viewSelection: anIndex] ]
]

{ #category : #converting }
GtPhlowContextMenuCompositeAction >> toActionOn: anItem index: anIndexSelection element: anElement [
	^ #()
]

{ #category : #converting }
GtPhlowContextMenuCompositeAction >> toMenuItemOn: anItem index: anIndexSelection element: anElement [
	<return: #Collection of: #BrMenuItem>
	<return: #BrMenuItems>
	| aResult |
	aResult := self toActionOn: anItem index: anIndexSelection element: anElement.
	(aResult isKindOf: BrMenuItems) ifTrue: [ ^ aResult ].

	^ (aResult 
		select: [ :anAction |
			self shouldShowAction: anAction item: anItem index: anIndexSelection])
		collect: [ :anAction | 
			self 
				convertToMenuItem: anAction 
				hostElement: anElement
				item: anItem 
				index: anIndexSelection ]
]
