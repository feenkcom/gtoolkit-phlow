Class {
	#name : #GtPhlowChangeActionAffectedMethodContext,
	#superclass : #GtPhlowChangeActionContext,
	#instVars : [
		'affectedClass',
		'affectedMethod'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'event handling' }
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
