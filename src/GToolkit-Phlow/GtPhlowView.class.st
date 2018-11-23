"
I am an abstract view.
"
Class {
	#name : #GtPhlowView,
	#superclass : #GtPhlowProtoView,
	#instVars : [
		'title',
		'priority',
		'definingMethod',
		'phlowActions'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #decorating }
GtPhlowView class >> composite [
	^ GtPhlowCompositeView new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowView class >> empty [
	^ GtPhlowEmptyView new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowView class >> explicit [
	^ GtPhlowExplicitView new 
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #testing }
GtPhlowView class >> isAbstract [
	^ self name = #GtPhlowView 
]

{ #category : #'message performing' }
GtPhlowView class >> on: anObject perform: aMessageSymbol [
	<return: #BlElement>
	^ self new on: anObject perform: aMessageSymbol
]

{ #category : #'adding - actions' }
GtPhlowView >> action: anOneArgBlock [
	| newPhlowAction |
	newPhlowAction := anOneArgBlock value: GtPhlowAction noAction.
	newPhlowAction definingMethod: self definingMethod.
	phlowActions add: newPhlowAction.
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon action: aValuable [
	self actionButtonIcon: anIcon label: nil action: aValuable
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon label: aStringOrRope action: aValuable [
	self action: [ :aPhlowAction | 
		aPhlowAction button 
			icon: anIcon;
			label: aStringOrRope;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonLabel: aString action: aValuable [
	self actionButtonIcon: nil label: aString action: aValuable
]

{ #category : #'adding - actions' }
GtPhlowView >> actionStencil: anActionStencil [
	self action: [ :aPhlowAction | 
		aPhlowAction explicit stencil: anActionStencil ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionsToolbarForElement: anElement [
	| aToolbar |

	aToolbar := BrToolbar new.
	aToolbar look: BrGlamorousToolbarLook.

	phlowActions do: [ :phlowAction |
		phlowAction asElementDo: [ :actionElement |
			aToolbar addItem: actionElement ] withElement: anElement ].

	 ^ aToolbar
]

{ #category : #'adding - actions' }
GtPhlowView >> addPhlowAction: aPhlowAction [
	phlowActions add: aPhlowAction.
]

{ #category : #'adding - actions' }
GtPhlowView >> addPhlowActions: aCollectionOfPhlowActions [
	aCollectionOfPhlowActions do: [ :eachPhlowAction | 
		self addPhlowAction: eachPhlowAction ]
]

{ #category : #accessing }
GtPhlowView >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtPhlowView >> definingMethod: anObject [
	definingMethod := anObject
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

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol [
	<return: #GtPhlowView>
	^ self on: anObject perform: aMessageSymbol withArguments: { self }
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withArguments: aCollectionOfArguments [
	<return: #GtPhlowView>
	^ [ thisContext
			object: anObject
			perform: aMessageSymbol
			withArguments: aCollectionOfArguments
			inClass: anObject class ] 
		on: Error 
		do: [ :anException | 
			anException freeze.
			GtPhlowViewWithError new
				definingMethod: self definingMethod;
				title: 'Error';
				error: anException ]
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withContext: aContext [
	<return: #GtPhlowView>
	^ self on: anObject perform: aMessageSymbol withArguments: { self. aContext }
]

{ #category : #accessing }
GtPhlowView >> priority [
	^ priority
]

{ #category : #accessing }
GtPhlowView >> priority: anObject [
	priority := anObject
]

{ #category : #accessing }
GtPhlowView >> title [
	^ title
]

{ #category : #accessing }
GtPhlowView >> title: aString [ 
	title := aString
]
