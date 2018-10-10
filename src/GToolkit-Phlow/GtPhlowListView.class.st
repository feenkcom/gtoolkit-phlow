Class {
	#name : #GtPhlowListView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'itemsBuilder',
		'itemElementStencilBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowListView >> asElementDo: aBlock [
	| list |
	list := BrColumnedList new.
	list := BrColumnedList new display: self itemsBuilder value.
	list addEventHandler: (GtInspectorListToSelectHandler new).
	list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
"	list column
		title: 'Icon';
		stencil: [ :aNode :index |
			| icon |
			icon := ([ aNode rawValue gtInspectorIcon ifNil: [ aNode rawValue class systemIcon ] ]
					on: Error 
					do: [ :error | self iconNamed: #smallWarningIcon ]).
			icon asElement].
"	list column
		title: 'Item';
		stencil: [ :aNode :index | 
			| itemElement |
			itemElement := self itemElementStencilBuilder value: aNode.
			itemElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
	list phlow beView; entity: self.
	^ aBlock value: list
]

{ #category : #initialization }
GtPhlowListView >> initialize [
	super initialize.
	itemElementStencilBuilder := [ :anObject | 
		(BrListLabelStencil matchParent: anObject gtDisplayString asRopedText) asElement ].
	itemsBuilder := [ { } ]
]

{ #category : #accessing }
GtPhlowListView >> itemElement: anObject [
	itemElementStencilBuilder := anObject
]

{ #category : #accessing }
GtPhlowListView >> itemElementStencilBuilder [
	^ itemElementStencilBuilder
]

{ #category : #accessing }
GtPhlowListView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #accessing }
GtPhlowListView >> itemsBuilder [
	^ itemsBuilder
]
