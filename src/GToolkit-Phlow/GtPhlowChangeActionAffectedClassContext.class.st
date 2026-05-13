Class {
	#name : #GtPhlowChangeActionAffectedClassContext,
	#superclass : #GtPhlowChangeActionContext,
	#instVars : [
		'affectedClass'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'instance  creation' }
GtPhlowChangeActionAffectedClassContext class >> forAffectedClass: aClass [
	^ self new affectedClass: aClass
]

{ #category : #accessing }
GtPhlowChangeActionAffectedClassContext >> affectedClass [
	^ affectedClass
]

{ #category : #accessing }
GtPhlowChangeActionAffectedClassContext >> affectedClass: anObject [
	affectedClass := anObject
]
