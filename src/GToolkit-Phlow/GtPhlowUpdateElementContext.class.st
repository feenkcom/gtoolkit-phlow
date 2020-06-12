Class {
	#name : #GtPhlowUpdateElementContext,
	#superclass : #GtPhlowUpdateCommand,
	#instVars : [
		'elementContext'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #convenience }
GtPhlowUpdateElementContext >> arguments [
	^ self buildContext arguments
]

{ #category : #convenience }
GtPhlowUpdateElementContext >> buildContext [
	<return: #GtPhlowBuildContext>
	^ self elementContext buildContext
]

{ #category : #convenience }
GtPhlowUpdateElementContext >> element [
	^ self elementContext element
]

{ #category : #accessing }
GtPhlowUpdateElementContext >> elementContext [
	^ elementContext
]

{ #category : #accessing }
GtPhlowUpdateElementContext >> elementContext: anObject [
	elementContext := anObject
]

{ #category : #evaluating }
GtPhlowUpdateElementContext >> execute [
	<return: #GtPhlowView>
	| aNewPhlow |
	self element hasParent ifFalse: [ ^ self ].
	aNewPhlow := GtPhlowView empty 
		on: self object 
		perform: self methodSelector 
		withArguments: self arguments.
	self elementContext entity: aNewPhlow.
	self elementContext syncUpdate.
	^ aNewPhlow
]

{ #category : #convenience }
GtPhlowUpdateElementContext >> methodSelector [
	^ self elementContext methodSelector
]

{ #category : #convenience }
GtPhlowUpdateElementContext >> object [
	^ self buildContext object
]
