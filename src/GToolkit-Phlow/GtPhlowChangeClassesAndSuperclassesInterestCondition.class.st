Class {
	#name : #GtPhlowChangeClassesAndSuperclassesInterestCondition,
	#superclass : #GtPhlowChangeInterestCondition,
	#instVars : [
		'classes'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeClassesAndSuperclassesInterestCondition >> classes [
	^ classes
]

{ #category : #accessing }
GtPhlowChangeClassesAndSuperclassesInterestCondition >> classes: anObject [
	classes := anObject
]

{ #category : #'api - testing' }
GtPhlowChangeClassesAndSuperclassesInterestCondition >> isInterestingClass: anAffectedClass [
	<return: #Boolean>
	^ self classes anySatisfy: [ :eachClass | 
		GtSystemUtility 
			isClass: eachClass 
			sameOrSubclassOf: anAffectedClass ]
]

{ #category : #'api - testing' }
GtPhlowChangeClassesAndSuperclassesInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ self isInterestingClass: anAffectedClass
]
