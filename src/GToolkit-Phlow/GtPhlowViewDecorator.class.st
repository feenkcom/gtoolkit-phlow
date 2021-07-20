"
I am a decorator of an `originalView` of which I keep track.

My subclasses typically offer fluent APIs for constructing a view based on external engines.


"
Class {
	#name : 'GtPhlowViewDecorator',
	#superclass : 'GtPhlowView',
	#instVars : [
		'originalView'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : 'testing' }
GtPhlowViewDecorator class >> isAbstract [
	^ self name = #GtPhlowViewDecorator 
]

{ #category : 'traversing' }
GtPhlowViewDecorator >> allParentDecoratorsDo: aBlock [
	self originalView ifNotNil: [ 
		aBlock value: self originalView.
		self originalView allParentDecoratorsDo: aBlock ]
]

{ #category : 'accessing - dynamic' }
GtPhlowViewDecorator >> decoratorsChain [
	| decorators |
	decorators := OrderedCollection with: self.
	self allParentDecoratorsDo: [ :aDecorator |
			decorators add: aDecorator ].
	^ decorators
]

{ #category : 'ui' }
GtPhlowViewDecorator >> gtDecoratorChainFor: aView [
	<gtView>
	^ aView list 
		title: 'Decorators' translated;
		priority: 4;
		items: [ self decoratorsChain ]
]

{ #category : 'accessing' }
GtPhlowViewDecorator >> originalView [
	<return: #GtPhlowView>
	^ originalView
]

{ #category : 'accessing' }
GtPhlowViewDecorator >> originalView: aView [
	originalView := aView
]
