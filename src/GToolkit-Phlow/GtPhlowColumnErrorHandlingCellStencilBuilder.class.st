Class {
	#name : #GtPhlowColumnErrorHandlingCellStencilBuilder,
	#superclass : #BrColumnCellStencilBuilder,
	#instVars : [
		'cellSpacing',
		'cellStencil'
	],
	#category : 'GToolkit-Phlow-Support - List columned'
}

{ #category : #'api - instantiation' }
GtPhlowColumnErrorHandlingCellStencilBuilder >> buildDefault [
	| aContainer |

	aContainer := self newCellContainer.
	
	(self itemType class = GtPhlowExceptionItemType) 
		ifTrue: [ 
			| anElement |
			anElement := self itemType exception asDebuggableElement vFitContent; hMatchParent.
			aContainer exception: anElement ]
		ifFalse: [ 
			[
				| anElement |
				anElement := cellStencil
					itemType: self itemType;
					column: column;
					columnIndex: columnIndex;
					build.

				aContainer content: anElement. ]
					on: Error
					do: [ :anException |
						| anElement |
					anElement := anException asDebuggableElement vFitContent; hMatchParent.
					aContainer exception: anElement ]  ].
	^ aContainer
]

{ #category : #accessing }
GtPhlowColumnErrorHandlingCellStencilBuilder >> cellSpacing [

	^ cellSpacing
]

{ #category : #accessing }
GtPhlowColumnErrorHandlingCellStencilBuilder >> cellSpacing: anObject [

	cellSpacing := anObject
]

{ #category : #accessing }
GtPhlowColumnErrorHandlingCellStencilBuilder >> cellStencil: aBrColumnCellStencilBuilder [
	cellStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #initialization }
GtPhlowColumnErrorHandlingCellStencilBuilder >> initialize [
	super initialize.
	
	cellSpacing := BlInsets empty
]

{ #category : #'instance creation' }
GtPhlowColumnErrorHandlingCellStencilBuilder >> newCellContainer [
	^ GtPhlowCellElement new
		hMatchParent;
		vFitContent;
		padding: self cellSpacing
]
