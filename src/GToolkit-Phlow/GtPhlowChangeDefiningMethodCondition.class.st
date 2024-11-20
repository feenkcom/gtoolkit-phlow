Class {
	#name : #GtPhlowChangeDefiningMethodCondition,
	#superclass : #GtPhlowChangeInterestCondition,
	#instVars : [
		'definingMethod'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeDefiningMethodCondition >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtPhlowChangeDefiningMethodCondition >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #'api - testing' }
GtPhlowChangeDefiningMethodCondition >> isInterestingClass: anAffectedClass [
	<return: #Boolean>
	^ false
]

{ #category : #'api - testing' }
GtPhlowChangeDefiningMethodCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ self definingMethod gtPhlowIncludesCompiledMethod: anAffectedMethod
]
