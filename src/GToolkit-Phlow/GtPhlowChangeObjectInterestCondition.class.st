Class {
	#name : #GtPhlowChangeObjectInterestCondition,
	#superclass : #GtPhlowChangeInterestCondition,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangeObjectInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ GtSystemUtility 
		isClass: self object class 
		sameOrSubclassOf: anAffectedClass
]

{ #category : #accessing }
GtPhlowChangeObjectInterestCondition >> object [
	^ object
]

{ #category : #accessing }
GtPhlowChangeObjectInterestCondition >> object: anObject [
	object := anObject
]
