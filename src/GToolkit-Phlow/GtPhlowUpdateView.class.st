"
I update a {{gtClass:GtPhlowView}} and its corresponding {{gtClass:BlElement}}.
I am used by {{gtClass:GtPhlowUpdateViewOnDefiningMethodChange}}.

1. # Updating View and Element


A supposively original view definition with three items:

{{gtExample:GtPhlowListViewExamples>>#modifiedElement|codeExpanded=false|previewExpanded=true}}

is updated to a new definition with ten elements:

{{gtExample:GtPhlowListViewExamples>>#updateOnDefiningMethodChange|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : 'GtPhlowUpdateView',
	#superclass : 'GtPhlowUpdateCommand',
	#category : 'GToolkit-Phlow-Updating'
}

{ #category : 'evaluating' }
GtPhlowUpdateView >> execute [
	<return: #GtPhlowView>
	| aNewPhlow anElement |
	self element hasParent ifFalse: [ ^ self ].
	self hasBuildContext ifFalse: [ ^ self ].
	aNewPhlow := GtPhlowView empty 
		on: self object 
		perform: self methodSelector 
		withSomeArguments: self arguments.
	anElement := aNewPhlow asElementDo: [ :theElement | theElement ].
	self scheduleValuable: [ 
		self replaceElementBy: anElement ].
	^ aNewPhlow
]

{ #category : 'private - updating' }
GtPhlowUpdateView >> replaceElementBy: anElement [
	| aParent |
	aParent := self element parent.
	aParent ifNil: [ ^ self ].
	self view replaceOldElement: self element by: anElement in: aParent.
]
