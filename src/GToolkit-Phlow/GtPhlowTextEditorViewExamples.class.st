Class {
	#name : #GtPhlowTextEditorViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'gt-extension' }
GtPhlowTextEditorViewExamples >> gtAutoUpdatingFor: aView [
	<gtView>
	| aString anAnnouncer |
	aString := 'How do you feenk today?'.
	anAnnouncer := Announcer new.
	^ aView textEditor
		title: 'Auto Updating Text';
		text: [ aString ];
		actionButtonIcon: BrGlamorousIcons add 
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

{ #category : #examples }
GtPhlowTextEditorViewExamples >> textView [
	<gtExample>
	| view element |
	view := GtPhlowView empty textEditor text: 'abc' asRopedText.
	view asElementDo: [ :el | element := el ].
	self assertSceneInformingElement: element withChildOfClass: BrEditor inView: view.
	"Do not be confused by by error '...can not install the same look instance on multiple widgets'"
	^ view
]
