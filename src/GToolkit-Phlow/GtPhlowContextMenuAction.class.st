Class {
	#name : #GtPhlowContextMenuAction,
	#superclass : #GtPhlowContextMenuBasicAction,
	#instVars : [
		'label',
		'actionComputation',
		'iconStencil',
		'tooltipText',
		'enableCondition',
		'id',
		'showCondition'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #'instance creation' }
GtPhlowContextMenuAction class >> label: aString action: aBlock [
	^ self new
		label: aString;
		action: aBlock
]

{ #category : #'instance creation' }
GtPhlowContextMenuAction class >> named: aString action: aBlock [
	^ self label: aString action: aBlock
]

{ #category : #'instance creation' }
GtPhlowContextMenuAction class >> named: aString action: aBlock if: aFilterBlock [
	^ self new
		name: aString;
		action: aBlock;
		filter: aFilterBlock
]

{ #category : #accessing }
GtPhlowContextMenuAction >> action [
	^ self actionComputation
]

{ #category : #'api - scripting' }
GtPhlowContextMenuAction >> action: aBlock [ 
	actionComputation := aBlock
]

{ #category : #accessing }
GtPhlowContextMenuAction >> actionComputation [
	^ actionComputation
]

{ #category : #converting }
GtPhlowContextMenuAction >> asItemBoundActionToItem: anItem index: anIndex [
	^ GtPhlowContextMenuItemBoundAction new
		targetAction: self;
		item: anItem;
		index: anIndex
]

{ #category : #accessing }
GtPhlowContextMenuAction >> collectInvidualActionsOn: aCollection forElement: anElement item: anObject index: anIndex [
	"At this point we collect the actions; for single actions it does not need anything else"
	aCollection add: self
]

{ #category : #'api - scripting' }
GtPhlowContextMenuAction >> enableIf: aBlock [ 
	enableCondition := aBlock
]

{ #category : #accessing }
GtPhlowContextMenuAction >> gtViewFilterFor: aView [
	<gtView>
	self filter ifNil: [ ^ aView empty ].

	(self filter isKindOf: Symbol)
		ifTrue: [ ^ aView textEditor
				title: 'Filter';
				priority: 2;
				text: [ self enabled ] ].

	^ aView forward
		title: 'Filter';
				priority: 2;
		object: [ self filter ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
GtPhlowContextMenuAction >> gtViewSourceFor: aView [
	<gtView>

	^ aView forward
		title: 'Source Code';
		priority: 1;
		object: [ self action ];
		view: #gtSourceCodeFor:
]

{ #category : #'api - scripting' }
GtPhlowContextMenuAction >> icon: anIconOrStencil [
	iconStencil := anIconOrStencil
]

{ #category : #accessing }
GtPhlowContextMenuAction >> iconStencil [
	^ iconStencil
]

{ #category : #'api - scripting' }
GtPhlowContextMenuAction >> id [
	^ id
]

{ #category : #accessing }
GtPhlowContextMenuAction >> id: anId [
	id := anId
]

{ #category : #accessing }
GtPhlowContextMenuAction >> label [
	^ label
]

{ #category : #accessing }
GtPhlowContextMenuAction >> label: aString [ 
	label := aString
]

{ #category : #accessing }
GtPhlowContextMenuAction >> name [
	^ self label
]

{ #category : #accessing }
GtPhlowContextMenuAction >> name: aString [ 
	self label: aString
]

{ #category : #printing }
GtPhlowContextMenuAction >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream nextPutAll: (self label ifNil: [ '' ]) ]
]

{ #category : #'api - scripting' }
GtPhlowContextMenuAction >> showIf: aBlock [ 
	showCondition := aBlock
]

{ #category : #converting }
GtPhlowContextMenuAction >> toMenuItemOn: anItem index: anItemIndex  element: anotherElement [
	"Return a menu item which will be displayed in a context menu.
	Context menu action can return also collection of menu items."

	<return: #BrMenuItem>
	^ (self asItemBoundActionToItem: anItem index: anItemIndex) asMenuItem
		
	"^ BrMenuActionItem new
		label: self name;
		action: [ :anElement | self action cull: anElement cull: anItem cull: anItemIndex ]"
]

{ #category : #'api - scripting' }
GtPhlowContextMenuAction >> tooltip: aTextOrString [
	self tooltipText: aTextOrString
]

{ #category : #accessing }
GtPhlowContextMenuAction >> tooltipText [
	^ tooltipText
]

{ #category : #accessing }
GtPhlowContextMenuAction >> tooltipText: aTextOrString [
	tooltipText := aTextOrString
]
