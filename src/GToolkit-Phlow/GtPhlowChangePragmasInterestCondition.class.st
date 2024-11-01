Class {
	#name : #GtPhlowChangePragmasInterestCondition,
	#superclass : #GtPhlowChangeInterestCondition,
	#instVars : [
		'pragmas'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangePragmasInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ self pragmas
		anySatisfy: [ :eachSymbol | anAffectedMethod hasPragmaNamed: eachSymbol ]
]

{ #category : #accessing }
GtPhlowChangePragmasInterestCondition >> pragmas [
	^ pragmas ifNil: [ Array empty ]
]

{ #category : #accessing }
GtPhlowChangePragmasInterestCondition >> pragmas: aCollectionOfSymbols [
	pragmas := aCollectionOfSymbols
]
