Class {
	#name : #GtPhlowColumnedListRowElementStencilBuilder,
	#superclass : #BrColumnedListRowElementStencilBuilder,
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #'api - instantiation' }
GtPhlowColumnedListRowElementStencilBuilder >> buildDefault [
	^ super buildDefault
		addLook: BrGlamorousListItemLook
]
