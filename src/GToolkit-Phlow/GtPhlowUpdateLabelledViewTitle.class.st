"
I update a ${class:BlElement}$ label that corresponds to a ${class:GtPhlowLabelledView}$ instance.
I am used by ${class:GtPhlowUpdateLabeledOnClassAndSuperClassChange}$.
I default ${class:GtPhlowLabelledView}$ uses ${class:GtPhlowLabelBuilder}$ to build labels.

!! Updating Element

A supposively original view definition:

${example:GtPhlowLabelledViewExamples>>#element|codeExpanded=false|previewExpanded=true}$

is updated to:

${example:GtPhlowLabelledViewExamples>>#updateLabel|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #GtPhlowUpdateLabelledViewTitle,
	#superclass : #GtPhlowUpdateCommand,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #evaluating }
GtPhlowUpdateLabelledViewTitle >> execute [
	<return: #GtPhlowLabelledView>
	self hasBuildContext ifFalse: [ ^ self ].
	self scheduleValuable: [
		self updateLabel ].
	^ self elementContext entity
]

{ #category : #updating }
GtPhlowUpdateLabelledViewTitle >> updateLabel [
	| aTitle |
	aTitle := self elementContext entity newLabel.
	self elementContext element viewModel tabs ifNotEmpty: [ :theTabModels | 
		theTabModels anyOne widgetDo: [ :aTab | aTab label: aTitle ] ]
]
