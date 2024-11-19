Class {
	#name : #GtPhlowChangeActionAffectedMethodContext,
	#superclass : #GtPhlowChangeActionContext,
	#instVars : [
		'affectedClass',
		'affectedMethod',
		'isTabSelected'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'instance creation' }
GtPhlowChangeActionAffectedMethodContext class >> forAffectedClass: aClass affectedMethod: aCompiledMethod [
	^ self new
		affectedClass: aClass;
		affectedMethod: aCompiledMethod
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> affectedClass [
	^ affectedClass
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> affectedClass: anObject [
	affectedClass := anObject
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> affectedMethod [
	^ affectedMethod
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> affectedMethod: anObject [
	affectedMethod := anObject
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> affectedMethodDefinition [
	^ self affectedMethod asRingDefinition
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> affectedMethodSelector [
	^ self affectedMethod selector
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> isTabSelected [
	^ isTabSelected ifNil: [ false ]
]

{ #category : #accessing }
GtPhlowChangeActionAffectedMethodContext >> isTabSelected: anObject [
	isTabSelected := anObject
]
