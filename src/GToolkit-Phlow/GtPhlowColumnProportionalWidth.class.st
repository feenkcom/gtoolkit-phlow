"
I extend the ${class:BrColumnProportionalWidth}$ by adding a ${class:BlLinearGradientPaint}$ gradient to the right of a ${class:BrColumn}$ cell element in order to visually separate two columns with a content larger than an available width.
"
Class {
	#name : #GtPhlowColumnProportionalWidth,
	#superclass : #BrColumnProportionalWidth,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #hook }
GtPhlowColumnProportionalWidth >> applyOn: anElement [
	| aShadow |
	aShadow := BlElement new
		background: (BlLinearGradientPaint horizontal from: (Color white alpha: 0) to: Color white);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c vertical matchParent.
			c horizontal exact: 30 ].
	anElement addChild: aShadow.
	super applyOn: anElement.
]
