"
I exemplify {{gtClass:GtPhlowTextEditorView}}.


"
Class {
	#name : #GtPhlowTextEditorViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - element' }
GtPhlowTextEditorViewExamples >> expectedElementClass [
	^ BrEditor
]

{ #category : #'gt-extension' }
GtPhlowTextEditorViewExamples >> gtAutoUpdatingFor: aView [
	<gtView>
	| aString anAnnouncer |
	aString := 'How do you feenk today?'.
	anAnnouncer := Announcer new.
	^ aView textEditor
		title: 'Auto Updating Text';
		text: [ aString ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			action: [ aString := aString, String cr,  
				{ 'I feenk well :-)'. 'I feenk glamorous :-D'. 'I feenk about moldable development ;-)' } atRandom. 
				anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #'gt-extension' }
GtPhlowTextEditorViewExamples >> gtBasicFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text';
		text: [ 'How do you feenk today?' ]
]

{ #category : #'gt-extension' }
GtPhlowTextEditorViewExamples >> myself [
	<gtExample>

	^ self
]

{ #category : #'examples - view' }
GtPhlowTextEditorViewExamples >> phlowView [
	<gtExample>
	^ GtPhlowView empty textEditor text: 'abc' asRopedText
]

{ #category : #initialization }
GtPhlowTextEditorViewExamples >> setFontSize [
	<gtExample>
	| aView anElement |
	aView := self phlowView.
	aView fontSize: 21.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assertViewElement: anElement ofClass: BrEditor inView: aView.
	^ aView
]

{ #category : #examples }
GtPhlowTextEditorViewExamples >> setFontSizeSecondAsElementDoCall [
	<gtExample>
	| view element |

	view := self setFontSize.
	view asElementDo: [ :el | element := el ].

	self assertViewElement: element ofClass: BrEditor inView: view.

	^ view
]

{ #category : #examples }
GtPhlowTextEditorViewExamples >> textView [
	<gtExample>
	| view element |

	view := GtPhlowView empty textEditor text: 'abc' asRopedText.
	
	self assert: view attributesBuilder class equals: BlTextDelegatedAttributesBuilder.
	
	view asElementDo: [ :el | element := el ].

	self assertViewElement: element ofClass: BrEditor inView: view.

	^ view
]

{ #category : #examples }
GtPhlowTextEditorViewExamples >> textViewSecondAsElementDoCall [
	<gtExample>
	| view element |

	view := self textView.
	view asElementDo: [ :el | element := el ].

	self assertViewElement: element ofClass: BrEditor inView: view.

	^ view
]
