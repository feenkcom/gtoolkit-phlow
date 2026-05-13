"
I am a {{gtClass:GtPhlowTitleLabelBuilder}}.
I build {{gtClass:BlText}} instances. I abbreviate long titles.
1. # Examples
## Long title

{{gtExample:GtPhlowLongTitleLabelBuilderExamples>>#longTitle_Block|codeExpanded=false|previewExpanded=true|previewHeight=180}}
1. ## Short title

{{gtExample:GtPhlowLongTitleLabelBuilderExamples>>#shortTitle_Block|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #GtPhlowLongTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'block'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowLongTitleLabelBuilder >> block [
	^ block
]

{ #category : #'api - accessing' }
GtPhlowLongTitleLabelBuilder >> block: aBlock [
	block := aBlock
]

{ #category : #building }
GtPhlowLongTitleLabelBuilder >> build [
	<return: #BlText>
	| aShortTitle aLongLabel |
	aLongLabel := self longLabel.
	aLongLabel ifNil: [ ^ BlText empty ].
	aLongLabel := aLongLabel asRopedText.
	aLongLabel size < 42 ifTrue: [ ^ aLongLabel ].
	
	aShortTitle := '' asRopedText.
	aShortTitle append: (aLongLabel from: 1 to: 12) asRopedText.
	aShortTitle appendString: '...'.
	aShortTitle append: (aLongLabel from: aLongLabel size - 12 to: aLongLabel size) asRopedText.
	
	^ aShortTitle
]

{ #category : #'gt-extensions' }
GtPhlowLongTitleLabelBuilder >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Build result';
		aptitude: [ BrGlamorousRegularEditorAptitude new ];
		text: [ 
			'Original title: ' asRopedText
				append: (self longLabel ifNil: [ '' ]) asRopedText;
				append: String cr asRopedText;
				append: 'Result: ' asRopedText;
				foreground: BrGlamorousColors disabledButtonTextColor;
				append: self build asRopedText ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect build result' 
			action: [ :aButton | aButton phlow spawnObject: self build ]
]

{ #category : #'private - accessing' }
GtPhlowLongTitleLabelBuilder >> longLabel [
	^ self block value
]
