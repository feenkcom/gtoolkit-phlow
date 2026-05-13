"
# Text list item builder


"
Class {
	#name : #GtPhlowListTextElementStencilBuilder,
	#superclass : #BrListItemElementStencilBuilder,
	#category : #'GToolkit-Phlow-Support - List'
}

{ #category : #'api - instantiation' }
GtPhlowListTextElementStencilBuilder >> buildDefault [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]
