Class {
	#name : #GtPhlowChangeInterestCondition,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangeInterestCondition >> isInterestingClass: anAffectedClass [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
GtPhlowChangeInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ self subclassResponsibility
]
