"
I am an abstract view.
"
Class {
	#name : #GtPhlowView,
	#superclass : #Object,
	#instVars : [
		'title',
		'priority',
		'definingMethod',
		'phlowActions'
	],
	#category : 'GToolkit-Phlow'
}

{ #category : #'message performing' }
GtPhlowView class >> on: anObject perform: aMessageSymbol [
	<return: #BlElement>
	^ self new on: anObject perform: aMessageSymbol
]

{ #category : #accessing }
GtPhlowView >> actionStencil: anActionStencil [
	| newPhlowAction |
	newPhlowAction := GtPhlowAction new.
	newPhlowAction stencil: anActionStencil.
	phlowActions add: newPhlowAction.
]

{ #category : #accessing }
GtPhlowView >> actionsToolbarForElement: anElement [
	| aToolbar |

	aToolbar := BrToolbar new.
	aToolbar look: BrGlamorousToolbarLook.

	phlowActions do: [ :phlowAction |
		phlowAction asElementDo: [ :actionElement |
			aToolbar addItem: actionElement ] withElement: anElement ].

	 ^ aToolbar
]

{ #category : #accessing }
GtPhlowView >> addPhlowAction: aPhlowAction [
	phlowActions add: aPhlowAction.
]

{ #category : #converting }
GtPhlowView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	self subclassResponsibility
]

{ #category : #decorating }
GtPhlowView >> composite [
	^ GtPhlowCompositeView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowView >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtPhlowView >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #decorating }
GtPhlowView >> empty [
	^ GtPhlowEmptyView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowView >> explicit [
	^ self taskItExplicit
]

{ #category : #converting }
GtPhlowView >> ifItHasContent: aBlock [
	^ aBlock value
]

{ #category : #initialization }
GtPhlowView >> initialize [
	super initialize.
	phlowActions := OrderedCollection new.
	priority := 50. "the lower the value, the closer to the left the tab appears"
	"self actionStencil: [ 
		| button |
		button := BrButton new.
		button 
				look: BrGlamorousButtonExteriorCircularLook + BrGlamorousButtonIconLook;
				icon: GLMUIThemeExtraIcons glamorousBrowse asElement ;
				action: [ button fireEvent: (GtPhlowObjectToSpawn new 
					object: self definingMethod;
					sourceElement: button) ] ]"
]

{ #category : #decorating }
GtPhlowView >> labelled [
	^ GtPhlowLabelledView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowView >> labelled: aStringOrText [
	^ self labelled label: aStringOrText
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol [
	<return: #BlElement>
	^ [ anObject perform: aMessageSymbol with: self ] 
		on: Error 
		do: [ :anException | 
			anException freeze.
			GtPhlowViewWithError new 
				title: 'Error';
				error: anException ]
]

{ #category : #accessing }
GtPhlowView >> priority [
	^ priority
]

{ #category : #accessing }
GtPhlowView >> priority: anObject [
	priority := anObject
]

{ #category : #decorating }
GtPhlowView >> sequentialExplicit [
	^ GtPhlowSequentialExplicitView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowView >> taskItExplicit [
	^ GtPhlowTaskItExplicitView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowView >> title [
	^ title
]

{ #category : #accessing }
GtPhlowView >> title: aString [ 
	title := aString
]
