Class {
	#name : #GtPhlowChangeAndInterestCondition,
	#superclass : #GtPhlowChangeBinaryInterestCondition,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangeAndInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ (self left isInterestingClass: anAffectedClass andMethod: anAffectedMethod)
		and: [ self right isInterestingClass: anAffectedClass andMethod: anAffectedMethod ]
]
