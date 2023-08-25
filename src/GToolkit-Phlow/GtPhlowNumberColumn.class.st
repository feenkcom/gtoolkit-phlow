Class {
	#name : #GtPhlowNumberColumn,
	#superclass : #GtPhlowTypedColumn,
	#instVars : [
		'formatComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - building' }
GtPhlowNumberColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	| aText |
	
	aText := formatComputation
		ifNil: [ aCellObject gtDisplayText ]
		ifNotNil: [ :aBlock | aBlock value: aCellObject ].

	aCellElement text: aText
]

{ #category : #'api - building' }
GtPhlowNumberColumn >> createCellElement [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude;
		alignCenterRight;
		hMatchParent;
		vFitContent
]

{ #category : #'api - configuration' }
GtPhlowNumberColumn >> format: aBlock [
	formatComputation := aBlock
]

{ #category : #accessing }
GtPhlowNumberColumn >> formatComputation [
	^ formatComputation
]
