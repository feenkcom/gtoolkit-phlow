"
I exemplify {{gtClass:GtPhlowTextEditorView}}.


"
Class {
	#name : #GtPhlowTextEditorViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'examples - element' }
GtPhlowTextEditorViewExamples >> expectedElementClass [
	^ BrVerticalPane
]

{ #category : #'gt-extension' }
GtPhlowTextEditorViewExamples >> gtAutoUpdatingFor: aView [
	<gtView>
	| aString anAnnouncer |
	aString := 'How do you feenk today?'.
	anAnnouncer := Announcer new.
	^ aView textEditor
		title: 'Auto updating text';
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
	self assertViewElement: anElement ofClass: BrVerticalPane inView: aView.
	self assert: (anElement childNamed: #editor) class equals: BrEditor.
	^ aView
]

{ #category : #examples }
GtPhlowTextEditorViewExamples >> setFontSizeSecondAsElementDoCall [
	<gtExample>
	| view element |

	view := self setFontSize.
	view asElementDo: [ :el | element := el ].

	self assertViewElement: element ofClass: BrVerticalPane inView: view.
	self assert: (element childNamed: #editor) class equals: BrEditor.

	^ view
]

{ #category : #examples }
GtPhlowTextEditorViewExamples >> textView [
	<gtExample>
	| view element |

	view := GtPhlowView empty textEditor text: 'abc' asRopedText.
	
	self assert: view attributesBuilder class equals: BlTextDelegatedAttributesBuilder.
	
	view asElementDo: [ :el | element := el ].

	self assertViewElement: element ofClass: BrVerticalPane inView: view.
	self assert: (element childNamed: #editor) class equals: BrEditor.
	^ view
]

{ #category : #examples }
GtPhlowTextEditorViewExamples >> textViewSecondAsElementDoCall [
	<gtExample>
	| view element |

	view := self textView.
	view asElementDo: [ :el | element := el ].

	self assertViewElement: element ofClass: BrVerticalPane inView: view.
	self assert: (element childNamed: #editor) class equals: BrEditor.

	^ view
]
