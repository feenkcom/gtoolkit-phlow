Class {
	#name : #GtPhlowChangeLackOfInterestCondition,
	#superclass : #GtPhlowChangeInterestCondition,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangeLackOfInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ false
]
