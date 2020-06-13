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
		withArguments: self arguments.
	BlUseAsyncFeatures 
		ifEnabledDo: [
			self element enqueueTask: (BlTaskAction new action: [ 
				self elementContext entity: aNewPhlow.
				self elementContext update. ]) ]
		otherwise: [ 
			self elementContext entity: aNewPhlow.
			self elementContext syncUpdate. ].
	^ aNewPhlow
]
