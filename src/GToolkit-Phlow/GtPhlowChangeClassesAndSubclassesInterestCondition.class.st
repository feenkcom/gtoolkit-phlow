Class {
	#name : #GtPhlowChangeClassesAndSubclassesInterestCondition,
	#superclass : #GtPhlowChangeInterestCondition,
	#instVars : [
		'superclasses'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangeClassesAndSubclassesInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ self superclasses anySatisfy: [ :eachClass | 
		GtSystemUtility 
			isClass: anAffectedClass 
			sameOrSubclassOf: eachClass ]
]

{ #category : #accessing }
GtPhlowChangeClassesAndSubclassesInterestCondition >> superclass: aClass [
	self superclasses: { aClass }
]

{ #category : #accessing }
GtPhlowChangeClassesAndSubclassesInterestCondition >> superclasses [
	^ superclasses ifNil: [ Array empty ]
]

{ #category : #accessing }
GtPhlowChangeClassesAndSubclassesInterestCondition >> superclasses: aCollectionOfClasses [
	superclasses := aCollectionOfClasses
]
