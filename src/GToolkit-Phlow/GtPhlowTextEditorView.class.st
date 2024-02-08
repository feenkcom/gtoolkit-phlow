Class {
	#name : #GtPhlowTextEditorView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'textBuilder',
		'attributesBuilder',
		'stylerSpecification',
		'aptitude'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowTextEditorView >> aptitude [
	^ aptitude
]

{ #category : #accessing }
GtPhlowTextEditorView >> aptitude: aBlockOrAptitudeClass [
	self
		assert: [ (aBlockOrAptitudeClass isKindOf: BrAptitude) not ] 
		description: [ 'Aptitude must be a valuable or just an aptitude class, but not an aptitude instance' ].

	aptitude := aBlockOrAptitudeClass
]

{ #category : #converting }
GtPhlowTextEditorView >> asElementDo: aBlock [
	| aBrickEditor aText aNewLook aNewStyler |

	aBrickEditor := self elementClass new.

	aText := self 
		textFor: aBrickEditor 
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].
	
	aNewLook := self 
		performBlock: [ self newAptitude ] 
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].
		
	aNewStyler := self 
		performBlock: [ stylerSpecification createBlStyler ] 
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].

	aBrickEditor 
		aptitude: aNewLook;
		styler: aNewStyler;
		enqueueTask: (BlTaskAction new action: [
			aBrickEditor text: aText ]).
			
	aBrickEditor
		matchParent;
		padding: (BlInsets all: 10).

	self beViewElement: aBrickEditor.

	^ aBlock value: aBrickEditor
]

{ #category : #accessing }
GtPhlowTextEditorView >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ attributesBuilder
]

{ #category : #converting }
GtPhlowTextEditorView >> elementClass [
	^ BrEditor
]

{ #category : #initialization }
GtPhlowTextEditorView >> initialize [
	super initialize.
	attributesBuilder := BlTextDelegatedAttributesBuilder new.
	aptitude := BrGlamorousRegularEditorAptitude.
	stylerSpecification := GtPhlowTextNullStylerSpecification new.
]

{ #category : #testing }
GtPhlowTextEditorView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'instance creation' }
GtPhlowTextEditorView >> newAptitude [
	| aNewAptitude |
	aNewAptitude := aptitude value asLook.
	self attributesBuilder applyOn: aNewAptitude attributesBuilder.
	^ aNewAptitude
]

{ #category : #accessing }
GtPhlowTextEditorView >> styler: aComputation [
	stylerSpecification := GtRemoteTextStylerComputableSpecification new 
		stylerComputation: aComputation
]

{ #category : #accessing }
GtPhlowTextEditorView >> stylerClassName: aStylerClassName [
	stylerSpecification := GtPhlowTextClassStylerSpecification new 
		stylerClassName: aStylerClassName
]

{ #category : #accessing }
GtPhlowTextEditorView >> stylerParserClassName: aParserClassName [
	stylerSpecification := GtPhlowTextParserStylerSpecification new 
		parserClassName: aParserClassName
]

{ #category : #accessing }
GtPhlowTextEditorView >> stylerSpecification [
	^ stylerSpecification
]

{ #category : #accessing }
GtPhlowTextEditorView >> text: anObject [
	textBuilder := anObject
]

{ #category : #accessing }
GtPhlowTextEditorView >> textBuilder [
	^ textBuilder
]

{ #category : #updating }
GtPhlowTextEditorView >> textFor: aBrickEditor onExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ (self textBuilder gtValueWithArgs: { aBrickEditor }) asRopedText ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #updating }
GtPhlowTextEditorView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| aText |
		aText := self
			textFor: aCurrentElement
			onExceptionErrorElement: [ :anErrorElement | 
				^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		self enqueueAction: [ aCurrentElement text: aText ] in: aCurrentElement ]
]

{ #category : #accessing }
GtPhlowTextEditorView >> withoutAptitude [
	self
		deprecated: 'Use #withoutAptitude instead.'
		transformWith: '`@receiver withoutLook' -> '`@receiver withoutAptitude'.
	aptitude := BrGlamorousEditorAptitude
]

{ #category : #accessing }
GtPhlowTextEditorView >> withoutLook [
	self
		deprecated: 'Use #withoutAptitude instead.'
		transformWith: '`@receiver withoutLook' -> '`@receiver withoutAptitude'.
	self withoutAptitude
]
