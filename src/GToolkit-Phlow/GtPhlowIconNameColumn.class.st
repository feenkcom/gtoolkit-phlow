Class {
	#name : #GtPhlowIconNameColumn,
	#superclass : #GtPhlowTypedColumn,
	#instVars : [
		'iconNameComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #testijg }
GtPhlowIconNameColumn class >> isAbstract [
	^ self name = #GtPhlowIconNameColumn
]

{ #category : #'api - building' }
GtPhlowIconNameColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	| computedIconName iconElement |

	computedIconName := iconNameComputation
		ifNil: [ aCellObject gtDisplayText ]
		ifNotNil: [ :aBlock |
			aBlock
				phlowValue: aCellObject
				withEnoughArguments: { aRowIndex . index } ].

	iconElement := self createIconElementFromName: computedIconName asSymbol.

	aCellElement
		removeChildren;
		addChild: iconElement.

	^ aCellElement
]

{ #category : #'api - building' }
GtPhlowIconNameColumn >> createCellElement [
	| container |

	container := BrHorizontalPane new.
	container hMatchParent; vFitContent.

	^ container
]

{ #category : #'api - building' }
GtPhlowIconNameColumn >> createIconElementFromName: anIconName [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtPhlowIconNameColumn >> iconName: anIconNameComputation [
	iconNameComputation := anIconNameComputation
]

{ #category : #accessing }
GtPhlowIconNameColumn >> iconNameComputation [
	^ iconNameComputation
]
