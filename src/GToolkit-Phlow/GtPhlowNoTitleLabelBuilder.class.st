"
I am a ${class:GtPhlowTitleLabelBuilder}$.
I ${method:GtPhlowNoTitleLabelBuilder>>#build|label=#selector}$ empty texts.
!! Usage
I am used as an *null object pattern>https://en.wikipedia.org/wiki/Null_object_pattern*.
!! Example
${example:GtPhlowNoTitleLabelBuilderExamples>>#basicBuilder|codeExpanded=false|previewExpanded=true|previewHeight=150}$
"
Class {
	#name : #GtPhlowNoTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #building }
GtPhlowNoTitleLabelBuilder >> build [
	^ BlText empty
]

{ #category : #'gt-extensions' }
GtPhlowNoTitleLabelBuilder >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Build result';
		look: [ BrGlamorousRegularEditorLook new 
			foreground: BrGlamorousColors disabledButtonTextColor ];
		text: [ 'The result is an empty string' ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect build result' 
			action: [ :aButton | aButton phlow spawnObject: self build ]
]
