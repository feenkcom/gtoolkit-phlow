"
I remove a ${class:GtPhlowCompositeView}$ subview and its corresponding ${class:BrTab}$ in ${class:BrTabGroup}$.
I am used by ${class:GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange}$.

!! Removing Tab

The first tab:

${example:GtPhlowCompositeViewExamples>>#element|codeExpanded=false|previewExpanded=true}$

is removed:

${example:GtPhlowCompositeViewExamples>>#removeViewOneDefinition|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtPhlowRemoveCompositeSubView,
	#superclass : #GtPhlowUpdateCommand,
	#instVars : [
		'ringDefinition',
		'compiledMethod'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #comparing }
GtPhlowRemoveCompositeSubView >> = anObject [
	^ super = anObject and: [ 
		self ringDefinition = anObject ringDefinition ]
]

{ #category : #'private - updating' }
GtPhlowRemoveCompositeSubView >> basicRemove [
	self element viewModel tabs 
		detect: [ :eachTabModel | eachTabModel widget 
			ifNotNil: [ :aWidget | 
				aWidget phlow definingMethod = self ringDefinition ]
			ifNil: [ false ] ] 
		ifFound: [ :aTabModel | self element viewModel removeTab: aTabModel ]
		ifNone: [ "do nothing" ].
	self view views
		detect: [ :eachView | eachView definingMethod = self ringDefinition ]
		ifFound: [ :aView | self view views remove: aView ifAbsent: [ "ignore" ] ]
		ifNone: [ "do nothing" ]
]

{ #category : #accessing }
GtPhlowRemoveCompositeSubView >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPhlowRemoveCompositeSubView >> compiledMethod: aCompiledMethod [
	compiledMethod := aCompiledMethod.
	ringDefinition := aCompiledMethod asRingDefinition.
]

{ #category : #evaluating }
GtPhlowRemoveCompositeSubView >> execute [
	<return: #CompiledMethod>
	self scheduleValuable: [ self basicRemove ].
	^ self compiledMethod
]

{ #category : #accessing }
GtPhlowRemoveCompositeSubView >> ringDefinition [
	^ self compiledMethod asRingDefinition
]
