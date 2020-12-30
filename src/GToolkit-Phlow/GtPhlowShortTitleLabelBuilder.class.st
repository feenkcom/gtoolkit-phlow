"
I am a ${class:GtPhlowTitleLabelBuilder}$.
I build ${class:BlText}$ and ${class:String}$ instances. I am used when a user does not want to abbreviate a possibly long title.
!! Examples
!!! Short title
${example:GtPhlowShortTitleLabelBuilderExamples>>#shortText_Block|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Long title
${example:GtPhlowShortTitleLabelBuilderExamples>>#longText|codeExpanded=false|previewExpanded=true|previewHeight=180}$

"
Class {
	#name : #GtPhlowShortTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'block'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
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
		look: [ BrGlamorousRegularEditorLook new ];
		text: [ self build ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect build result' 
			action: [ :aButton | aButton phlow spawnObject: self build ]
]
