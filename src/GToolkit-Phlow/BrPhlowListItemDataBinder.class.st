Class {
	#name : #BrPhlowListItemDataBinder,
	#superclass : #BrListItemDataBinder,
	#instVars : [
		'itemStencil'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #building }
BrPhlowListItemDataBinder >> build [
	<return: #BrStencil>
	^ [ self itemElement phlow isException
			ifTrue: [ self itemElement: self itemStencil build ].
		super build. ]
			on: Error 
			do: [ :anException | 
				| anElement |
				anElement := anException asDebuggableElement.
				anElement phlow beException.
				anElement padding: self newItemElementPadding.
				anElement ]
]

{ #category : #accessing }
BrPhlowListItemDataBinder >> itemStencil [
	^ itemStencil
]

{ #category : #accessing }
BrPhlowListItemDataBinder >> itemStencil: anObject [
	itemStencil := anObject
]

{ #category : #'instance creation' }
BrPhlowListItemDataBinder >> newItemElementPadding [
	^ BlInsets
		top: 3
		left: 10
		bottom: 3
		right: 10
]
