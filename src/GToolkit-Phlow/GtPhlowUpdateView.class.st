"
I update a ${class:GtPhlowView}$ and its corresponding ${class:BlElement}$.
I am used by ${class:GtPhlowUpdateViewOnDefiningMethodChange}$.

!! Updating View and Element

A supposively original view definition with three items:

${example:GtPhlowListViewExamples>>#modifiedElement|codeExpanded=false|previewExpanded=true}$

is udpated to a new definition with ten elements:

${example:GtPhlowListViewExamples>>#updateOnDefiningMethodChange|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #GtPhlowUpdateView,
	#superclass : #GtPhlowUpdateCommand,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #evaluating }
GtPhlowUpdateView >> execute [
	<return: #GtPhlowView>
	| aNewPhlow |
	self element hasParent ifFalse: [ ^ self ].
	self hasBuildContext ifFalse: [ ^ self ].
	aNewPhlow := GtPhlowView empty 
		on: self object 
		perform: self methodSelector 
		withSomeArguments: self arguments.
	self scheduleValuable: [ 
		self updateElementWithNewPhlowView: aNewPhlow ].
	^ aNewPhlow
]

{ #category : #'private - updating' }
GtPhlowUpdateView >> updateElementWithNewPhlowView: aNewPhlow [
	self elementContext entity: aNewPhlow.
	self elementContext syncUpdate.
]
