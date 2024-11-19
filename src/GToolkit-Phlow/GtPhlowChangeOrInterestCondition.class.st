Class {
	#name : #GtPhlowChangeOrInterestCondition,
	#superclass : #GtPhlowChangeBinaryInterestCondition,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - testing' }
GtPhlowChangeOrInterestCondition >> isInterestingClass: anAffectedClass [
	<return: #Boolean>
	^ (self left isInterestingClass: anAffectedClass)
		or: [ self right isInterestingClass: anAffectedClass ]
]

{ #category : #'api - testing' }
GtPhlowChangeOrInterestCondition >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	<return: #Boolean>
	^ (self left isInterestingClass: anAffectedClass andMethod: anAffectedMethod)
		or: [ self right isInterestingClass: anAffectedClass andMethod: anAffectedMethod ]
]
