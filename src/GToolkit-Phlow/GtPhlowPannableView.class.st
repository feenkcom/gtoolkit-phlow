Class {
	#name : #GtPhlowPannableView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'stencilBuilder',
		'element'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowPannableView >> asElementDo: aBlock [
	self assert: stencilBuilder notNil description: 'The stencil should be initialized'.
	element := [ stencilBuilder asElement asPannableElement ] 
		on: Error 
		do: [:error | 
			error freeze.
			GtPhlowViewWithError new error: error; asElementDo: [ :errorElement | errorElement ] ].
	element phlow beView; entity: self.
	^ aBlock value: element.
]

{ #category : #initialization }
GtPhlowPannableView >> initialize [
	super initialize.
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomin asElement ;
			action: [ element zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomout asElement ;
			action: [ element zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomtofit asElement ;
			action: [ element zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons actualsize asElement;
			action: [ element zoomToActualSize ] ]
]

{ #category : #accessing }
GtPhlowPannableView >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #accessing }
GtPhlowPannableView >> stencilBuilder [
	^ stencilBuilder
]

{ #category : #updating }
GtPhlowPannableView >> updateContent: anElement [
	"anElement is previsously computed content from asElementDo:"
	
	self asElementDo: [ :aNewElement | 
		| aParent |
		aParent := anElement parent.
		aNewElement phlow beViewContent; entity: self.
		aParent replaceChild: anElement with: aNewElement ].
	
]
