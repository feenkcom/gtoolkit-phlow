Class {
	#name : #GtPhlowNumberColumn,
	#superclass : #GtPhlowTypedColumn,
	#instVars : [
		'formatComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #private }
GtPhlowNumberColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	| aText |
	aText := formatComputation
		ifNil: [ aCellObject gtDisplayText ]
		ifNotNil: [ :aBlock | aBlock value: aCellObject ].
	aCellElement text: aText
]

{ #category : #private }
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
