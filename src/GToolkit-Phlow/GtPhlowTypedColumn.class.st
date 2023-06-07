Class {
	#name : #GtPhlowTypedColumn,
	#superclass : #GtPhlowColumn,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - building' }
GtPhlowTypedColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	self subclassResponsibility
]

{ #category : #'api - building' }
GtPhlowTypedColumn >> configureColumn: aBrColumn [
	super configureColumn: aBrColumn.

	aBrColumn
		cellStencil: (self computeDecoratedCellStencil: (MessageSend receiver: self selector: #createCellElement));
		dataBinder: (self computeDecoratedDataBinder: (MessageSend receiver: self selector: #bindToCellElement:cellObject:atPosition:))
]

{ #category : #'api - building' }
GtPhlowTypedColumn >> createCellElement [
	^ self subclassResponsibility
]
