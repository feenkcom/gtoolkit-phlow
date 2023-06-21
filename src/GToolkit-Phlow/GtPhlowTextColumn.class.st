Class {
	#name : #GtPhlowTextColumn,
	#superclass : #GtPhlowTypedColumn,
	#instVars : [
		'formatComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - building' }
GtPhlowTextColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	| aText |

	aText := formatComputation
		ifNil: [ aCellObject gtDisplayText ]
		ifNotNil: [ :aBlock |
			aBlock
				phlowValue: aCellObject
				withEnoughArguments: { aRowIndex . index } ].

	aCellElement text: aText gtDisplayText
]

{ #category : #'api - building' }
GtPhlowTextColumn >> createCellElement [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]

{ #category : #'api - configuration' }
GtPhlowTextColumn >> format: aBlock [
	formatComputation := aBlock
]

{ #category : #accessing }
GtPhlowTextColumn >> formatComputation [
	^ formatComputation
]
