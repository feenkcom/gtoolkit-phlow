Class {
	#name : #GtPhlowUpdateElementContext,
	#superclass : #GtPhlowUpdateCommand,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #evaluating }
GtPhlowUpdateElementContext >> execute [
	<return: #GtPhlowView>
	| aNewPhlow |
	self element hasParent ifFalse: [ ^ self ].
	aNewPhlow := GtPhlowView empty 
		on: self object 
		perform: self methodSelector 
		withSomeArguments: self arguments.
	self scheduleValuable: [ 
		self updateElementWithNewPhlowView: aNewPhlow ].
	^ aNewPhlow
]

{ #category : #'private - updating' }
GtPhlowUpdateElementContext >> updateElementWithNewPhlowView: aNewPhlow [
	self elementContext entity: aNewPhlow.
	self elementContext update.
]