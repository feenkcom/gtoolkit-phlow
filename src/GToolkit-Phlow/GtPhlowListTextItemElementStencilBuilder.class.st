"
# Text list item builder


"
Class {
	#name : 'GtPhlowListTextItemElementStencilBuilder',
	#superclass : 'BrListItemElementStencilBuilder',
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'api - instantiation' }
GtPhlowListTextItemElementStencilBuilder >> buildDefault [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude + BrGlamorousListItemAptitude;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]
