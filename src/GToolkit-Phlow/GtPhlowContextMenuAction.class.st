Class {
	#name : #GtPhlowContextMenuAction,
	#superclass : #Object,
	#instVars : [
		'name',
		'action',
		'filter',
		'enabled'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #'instance creation' }
GtPhlowContextMenuAction class >> named: aString action: aBlock [
	^ self new
		name: aString;
		action: aBlock
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
	^ action
]

{ #category : #accessing }
GtPhlowContextMenuAction >> action: aBlock [ 
	action := aBlock
]

{ #category : #converting }
GtPhlowContextMenuAction >> asAssociation [
	^ name -> action
]

{ #category : #accessing }
GtPhlowContextMenuAction >> filter [

	^ filter
]

{ #category : #accessing }
GtPhlowContextMenuAction >> filter: anObject [

	filter := anObject
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
	(self action isKindOf: Symbol)
		ifTrue: [ ^ aView textEditor
				title: 'Action';
				priority: 1;
				text: [ self action ] ].
	^ aView forward
		title: 'Source Code';
		priority: 1;
		object: [ self action ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
GtPhlowContextMenuAction >> name [
	^ name
]

{ #category : #accessing }
GtPhlowContextMenuAction >> name: aString [ 
	name := aString
]

{ #category : #converting }
GtPhlowContextMenuAction >> respondsToItem: anItem [
	^ self filter ifNil: [ true ] ifNotNil: [ :aFilter | aFilter value: anItem ]
]

{ #category : #converting }
GtPhlowContextMenuAction >> toActionOn: anItem [
	^ self name -> [ :anElement | self action cull: anElement cull: anItem ]
]

{ #category : #converting }
GtPhlowContextMenuAction >> toMenuItemOn: anItem [
	"Return a menu item which will be displayed in a context menu.
	Context menu action can return also collection of menu items."

	<return: #BrMenuItem>
	^ BrMenuActionItem new
		label: self name;
		action: [ :anElement | self action cull: anElement cull: anItem ]
]
