"
I am a {{gtClass:GtPhlowTitleLabelBuilder}}.
I build {{gtClass:BlText}} and {{gtClass:String}} instances. I am used when a user does not want to abbreviate a possibly long title.
1. # Examples
## Short title

{{gtExample:GtPhlowShortTitleLabelBuilderExamples>>#shortText_Block|codeExpanded=false|previewExpanded=true|previewHeight=180}}
1. ## Long title

{{gtExample:GtPhlowShortTitleLabelBuilderExamples>>#longText|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #GtPhlowShortTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'block'
	],
	#category : 'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowShortTitleLabelBuilder >> block [
	^ block
]

{ #category : #'api - accessing' }
GtPhlowShortTitleLabelBuilder >> block: anObject [
	block := anObject
]

{ #category : #'api - building' }
GtPhlowShortTitleLabelBuilder >> build [
	^ self block value ifNil: [ BlText empty ]
]

{ #category : #'gt-extensions' }
GtPhlowShortTitleLabelBuilder >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Build result';
		aptitude: [ BrGlamorousRegularEditorAptitude new ];
		text: [ self build ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect build result' 
			action: [ :aButton | aButton phlow spawnObject: self build ]
]
