Class {
	#name : #GtPhlowCompositeViewBuilder,
	#superclass : #GtPhlowViewBuilder,
	#instVars : [
		'viewsSelector'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #building }
GtPhlowCompositeViewBuilder >> buildView [
	<return: #GtPhlowCompositeView>
	| aView |
	aView := self view composite views: self views.
	self addBuildContext: aView.
	^ aView
]

{ #category : #accessing }
GtPhlowCompositeViewBuilder >> defaultViewsSelector [
	^ #gtViewsInContext:
]

{ #category : #views }
GtPhlowCompositeViewBuilder >> views [
	<return: #Array of: #GtPhlowView>
	^ thisContext
		object: self object 
		perform: self viewsSelector
		withArguments: {self context}
		inClass: self object  class

	"^ self object gtViewsInContext: self context"
]

{ #category : #accessing }
GtPhlowCompositeViewBuilder >> viewsSelector [
	^ viewsSelector ifNil: [
		self defaultViewsSelector ]
]

{ #category : #accessing }
GtPhlowCompositeViewBuilder >> viewsSelector: aSelector [
	self assert: [
		viewsSelector isNil and: [
			aSelector notNil ] ].
	
	viewsSelector := aSelector
]
