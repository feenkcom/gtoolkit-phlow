Class {
	#name : #GtPhlowAddCompositeSubView,
	#superclass : #GtPhlowUpdateCommand,
	#instVars : [
		'compiledMethod'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #comparing }
GtPhlowAddCompositeSubView >> = anObject [
	^ super = anObject and: [ 
		self compiledMethod = anObject compiledMethod ]
]

{ #category : #'private - updating' }
GtPhlowAddCompositeSubView >> addTab: aTab ofView: aPhlowView [
	self scheduleValuable: [ self basicAddTab: aTab ofView: aPhlowView ]
]

{ #category : #'private - updating' }
GtPhlowAddCompositeSubView >> basicAddTab: aTab ofView: aPhlowView [
	self element addTab: aTab.
	self view views add: aPhlowView.
]

{ #category : #accessing }
GtPhlowAddCompositeSubView >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPhlowAddCompositeSubView >> compiledMethod: aCompiledMethod [
	compiledMethod := aCompiledMethod
]

{ #category : #evaluating }
GtPhlowAddCompositeSubView >> execute [
	<return: #GtPhlowView>
	| aNewView |
	self hasBuildContext ifFalse: [ ^ self ].
	aNewView := self newPhlowSubView.
	GtPhlowUtility 
		createSafelyTabElementFor: aNewView 
		andDo: [ :aTab | self addTab: aTab ofView: aNewView ].
	^ aNewView
]

{ #category : #'instance creation' }
GtPhlowAddCompositeSubView >> newPhlowSubView [
	^ GtPhlowView empty
		on: self object
		perform: self compiledMethod selector
		withSomeArguments: self arguments
]
