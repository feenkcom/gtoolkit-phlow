"
I add a {{gtClass:GtPhlowCompositeView}} subview as a {{gtClass:BrTab}} in {{gtClass:BrTabGroup}}.
I am used by {{gtClass:GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange}}.

1. # Adding Tab


In the composite view with two tabs:

{{gtExample:GtPhlowCompositeViewExamples>>#element|codeExpanded=false|previewExpanded=true}}

a third is added:

{{gtExample:GtPhlowCompositeViewExamples>>#addViewThreeDefinition|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowAddCompositeSubView,
	#superclass : #GtPhlowUpdateCommand,
	#instVars : [
		'compiledMethod',
		'ringDefinition'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #comparing }
GtPhlowAddCompositeSubView >> = anObject [
	^ super = anObject and: [ 
		self ringDefinition = anObject ringDefinition ]
]

{ #category : #'private - updating' }
GtPhlowAddCompositeSubView >> addTab: aTab ofView: aPhlowView [
	self scheduleValuable: [ self basicAddTab: aTab ofView: aPhlowView ]
]

{ #category : #'private - updating' }
GtPhlowAddCompositeSubView >> basicAddTab: aTab ofView: aPhlowView [
	| anIndex |
	anIndex := GtPhlowUtility
		findIndexFor: aPhlowView
		in: self view views.
	self element addTab: aTab at: anIndex.
	self view views add: aPhlowView beforeIndex: anIndex.
]

{ #category : #accessing }
GtPhlowAddCompositeSubView >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPhlowAddCompositeSubView >> compiledMethod: aCompiledMethod [
	compiledMethod := aCompiledMethod.
	ringDefinition := aCompiledMethod asRingDefinition.
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

{ #category : #accessing }
GtPhlowAddCompositeSubView >> ringDefinition [
	^ ringDefinition
]
