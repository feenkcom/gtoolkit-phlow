"
I am a simple phlow tool that renders multiple views and actions from a target object using {{gtClass:GtPhlowMultipleViewsToolContentElementModel}}.
"
Class {
	#name : #GtMultipleViewsForExamplesPhlowTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #converting }
GtMultipleViewsForExamplesPhlowTool >> asElementDo: aBlock [
	| toolContentModel contentElement |
	
	toolContentModel := GtPhlowMultipleViewsToolContentElementModel forPhlowTool: self.
	toolContentModel headerTitleComputation: [ 'Object: ', self object printString  ].
	
	contentElement := GtPhlowMultipleViewsContentElement new.
	contentElement toolContentModel: toolContentModel.
	
	^ aBlock cull: contentElement cull: self
]

{ #category : #accessing }
GtMultipleViewsForExamplesPhlowTool >> icon [
	^ BrGlamorousVectorIcons changes
]

{ #category : #accessing }
GtMultipleViewsForExamplesPhlowTool >> name [
	^ 'Composite view tool'
]

{ #category : #accessing }
GtMultipleViewsForExamplesPhlowTool >> object [
	^ object
]

{ #category : #accessing }
GtMultipleViewsForExamplesPhlowTool >> object: anObject [
	object := anObject.
	^ self
]

{ #category : #accessing }
GtMultipleViewsForExamplesPhlowTool >> tabLook [
	^ BrGlamorousTabSwitcherWithLabelAndIconAptitude
]
