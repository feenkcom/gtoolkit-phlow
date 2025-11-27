Class {
	#name : #GtPhlowActionNotProvidedError,
	#superclass : #Error,
	#instVars : [
		'object',
		'selector',
		'arguments',
		'parentAction',
		'returnedObject'
	],
	#category : #'GToolkit-Phlow-Support - Exceptions'
}

{ #category : #'ui - building' }
GtPhlowActionNotProvidedError >> actionMethod [
	^ object class lookupSelector: selector
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> arguments [
	^ arguments
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> arguments: anObject [
	arguments := anObject
]

{ #category : #'ui - building' }
GtPhlowActionNotProvidedError >> createAnnotatedCoderElement [
	| coder returnsStyler coderViewModel coderElement |
	coder := GtPharoMethodCoder forMethod: self actionMethod asRingDefinition.

	returnsStyler := GtPhlowReturnExplanationLinkStyler new.

	coder addOns addStyler: returnsStyler.

	coderViewModel := coder asCoderViewModel.
	coderViewModel expanded: true.

	coderElement := coderViewModel asElement.	"asExpandedOnlyElement vFitContentLimited"
	coderElement margin: (BlInsets all: 10).

	^ coderElement
]

{ #category : #'ui - building' }
GtPhlowActionNotProvidedError >> createExplanationText [
	^ 'The Phlow action created by the method ' asRopedText
			,(self actionMethod printString asRopedText italic)
			,' returned a ' asRopedText
			, (self returnedObject class gtDisplayText glamorousExplanationFor: #ReturnNode)
			, ' kind of object. A phlow action is expected.' asRopedText
]

{ #category : #'ui - building' }
GtPhlowActionNotProvidedError >> createExplanationWithCoderElement [
	| container |
	container := BrVerticalPane new
		matchParent.
				
	container addChild: (BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: self createExplanationText;
		margin: (BlInsets all: 10);
		hMatchParent;
		vFitContent).
				
	container addChild: self createAnnotatedCoderElement.
				
	container explainer isExplanationHolder: true.
	^ container
]

{ #category : #'gt - extensions' }
GtPhlowActionNotProvidedError >> gtViewViewCodeWithExplanationFor: aView inContext: aPhlowContext [
	<gtView>
	<gtExceptionView>
	^ aView explicit
		title: 'View code';
		priority: 0;
		stencil: [ self createExplanationWithCoderElement ];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: self actionMethod) ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect returned object'
			action: [ :aButton | aButton phlow spawnObject: self returnedObject ]
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> object [
	^ object
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> parentAction [
	^ parentAction
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> parentAction: anObject [
	parentAction := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> returnedObject [
	^ returnedObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> returnedObject: anObject [
	returnedObject := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> selector [
	^ selector
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> selector: anObject [
	selector := anObject
]
