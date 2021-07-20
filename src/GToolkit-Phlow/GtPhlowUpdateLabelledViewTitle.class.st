"
I update a {{gtClass:BlElement}} label that corresponds to a {{gtClass:GtPhlowLabelledView}} instance.
I am used by {{gtClass:GtPhlowUpdateLabeledOnClassAndSuperClassChange}}.
I default {{gtClass:GtPhlowLabelledView}} uses {{gtClass:GtPhlowLabelBuilder}} to build labels.

1. # Updating Element


A supposively original view definition:

{{gtExample:GtPhlowLabelledViewExamples>>#element|codeExpanded=false|previewExpanded=true}}

is updated to:

{{gtExample:GtPhlowLabelledViewExamples>>#updateLabel|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : 'GtPhlowUpdateLabelledViewTitle',
	#superclass : 'GtPhlowUpdateCommand',
	#category : 'GToolkit-Phlow-Updating'
}

{ #category : 'evaluating' }
GtPhlowUpdateLabelledViewTitle >> execute [
	<return: #GtPhlowLabelledView>
	self hasBuildContext ifFalse: [ ^ self ].
	self scheduleValuable: [
		self updateLabel ].
	^ self elementContext entity
]

{ #category : 'updating' }
GtPhlowUpdateLabelledViewTitle >> updateLabel [
	| aTitle |
	aTitle := self elementContext entity newLabel.
	self elementContext element viewModel tabs ifNotEmpty: [ :theTabModels | 
		theTabModels anyOne widgetDo: [ :aTab | aTab label: aTitle ] ]
]
