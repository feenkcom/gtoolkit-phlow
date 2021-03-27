"
I am a ${class:GtPhlowTitleLabelBuilder}$.
I build short labels, ${class:BlText}$ and ${class:String}$ instances, composed of ${method:GtPhlowToolTitleLabelBuilder>>#toolName|label=#selector}$ and ${method:GtPhlowToolTitleLabelBuilder>>#subjectName|label=#selector}$. The subject name may be abbreviated.
!! Examples
!!! Abbreviated subject name
${example:GtPhlowToolTitleLabelBuilderExamples>>#longTitle_Block|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Provided short subject name
${example:GtPhlowToolTitleLabelBuilderExamples>>#shortTitle_Block|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Missing subject name
${example:GtPhlowToolTitleLabelBuilderExamples>>#noSubjectName|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Missing tool name
${example:GtPhlowToolTitleLabelBuilderExamples>>#noToolName|codeExpanded=false|previewExpanded=true|previewHeight=180}$

"
Class {
	#name : #GtPhlowToolTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'toolName',
		'subjectName'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - building' }
GtPhlowToolTitleLabelBuilder >> build [
	<return: #BlText>
	| aTitle aSubject |
	aTitle := self toolName value.
	aTitle ifNil: [ ^ BlText empty ].
	aTitle := aTitle copy asRopedText.
	aSubject := self subjectShortName.
	aSubject ifEmpty: [ ^ aTitle ].
	aTitle appendString: ': '.
	aTitle append: aSubject.
	^ aTitle
]

{ #category : #'gt-extensions' }
GtPhlowToolTitleLabelBuilder >> gtResultFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Build result';
		aptitude: [ BrGlamorousRegularEditorAptitude new ];
		text: [ 
			'Tool name: ' asRopedText
				append: (self toolName value ifNil: [ '' ]) asRopedText;
				append: String cr asRopedText;
				append: 'Subject name: ' asRopedText;
				append: (self subjectName value ifNil: [ '' ]) asRopedText;
				append: String cr asRopedText;
				append: 'Result: ' asRopedText;
				foreground: BrGlamorousColors disabledButtonTextColor;
				append: self build asRopedText ];
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect build result' 
			action: [ :aButton | aButton phlow spawnObject: self build ]
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> subjectName [
	^ subjectName
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> subjectName: anObject [
	subjectName := anObject
]

{ #category : #'private - building' }
GtPhlowToolTitleLabelBuilder >> subjectShortName [
	<return: #BlRopedText>
	| aTitle aSubject |
	aSubject := self subjectName value.
	aSubject ifNil: [ ^ BlText empty ].
	aSubject := aSubject asRopedText.
	aSubject size < 42 ifTrue: [ ^ aSubject ].
	
	aTitle := '' asRopedText.
	aTitle append: (aSubject from: 1 to: 12) asRopedText.
	aTitle appendString: '...'.
	aTitle append: (aSubject from: aSubject size - 12 to: aSubject size) asRopedText.
	
	^ aTitle
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> toolName [
	^ toolName
]

{ #category : #'api - accessing' }
GtPhlowToolTitleLabelBuilder >> toolName: anObject [
	toolName := anObject
]
