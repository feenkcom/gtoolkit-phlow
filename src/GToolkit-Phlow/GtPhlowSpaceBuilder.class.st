"
We will eventually remove it as we think that it is more meanigful to move the logic to {{gtClass:BlSpace}}. 

I create a {{gtClass:BlSpace}} and requests to show it using {{gtMethod:BlElement >> #showSpace:}}. 
You can use me by calling:
- {{gtMethod:GtPhlowElementContext >> #spaceBuilder | label=anElement phlow spaceBuilder ... ; show}}, 
- {{gtMethod:GtPhlowElementContext >> #showObject: | label=anElement phlow showObject: anObject}}, 
- {{gtMethod:GtPhlowElementContext >> #spawnOrShowObject: | label=anElement phlow spawnOrShowObject: anObject}}, and
- {{gtMethod:BlSpace class >> #spaceBuilder | label=BlSpace spaceBuilder}}.

For other cases, see my methods.

"
Class {
	#name : #GtPhlowSpaceBuilder,
	#superclass : #Object,
	#instVars : [
		'fromElement',
		'icon',
		'title',
		'stencil',
		'extent'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - actions' }
GtPhlowSpaceBuilder >> create [
	<return: #BlSpace>
	| aSpace |
	aSpace := BlSpace new.
	self title ifNotNil: [ :aString | 
		aSpace title: aString ].
	self icon ifNotNil: [ :aStencil | 
		aSpace icon: aStencil ].
	self extent ifNotNil: [ :aPoint | 
		aSpace extent: aPoint ].
	self stencil ifNotNil: [ :aStencil | 
		aSpace addChild: aStencil asElement ].
	aSpace root background: Color transparent.
	aSpace withSceneDriller.

	^ aSpace
]

{ #category : #initialization }
GtPhlowSpaceBuilder >> defaultExtent [
	^ 1200 @ 600
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> extent [
	^ extent ifNil: [ extent := self defaultExtent ]
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> fromElement [
	^ fromElement
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> fromElement: anElement [
	"Set an element that requests the show space action"

	fromElement := anElement
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> icon [
	^ icon
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> icon: anIconStencil [
	"Set space window icon"

	icon := anIconStencil
]

{ #category : #'api - actions' }
GtPhlowSpaceBuilder >> show [
	<return: #BlSpace>
	| aSpace |
	aSpace := self create.
	self fromElement 
		ifNil: [ aSpace show ] 
		ifNotNil: [ :anElement | 
			"Show space immediatelly because anElement might be removed after this request.
			See https://github.com/feenkcom/gtoolkit/issues/4217"
			anElement showSpace: aSpace ].
			
	^ aSpace
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> stencil [
	^ stencil
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> stencil: anElementStencil [
	"Set element that will be added to a newly created space"

	stencil := anElementStencil
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> title [
	^ title
]

{ #category : #accessing }
GtPhlowSpaceBuilder >> title: aString [
	"Set a space title title"

	title := aString
]
