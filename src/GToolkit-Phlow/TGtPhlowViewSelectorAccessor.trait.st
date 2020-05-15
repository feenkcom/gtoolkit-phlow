Trait {
	#name : #TGtPhlowViewSelectorAccessor,
	#instVars : [
		'selector'
	],
	#traits : 'TGtPhlowViewSelectorAssertion',
	#classTraits : 'TGtPhlowViewSelectorAssertion classTrait',
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #defaults }
TGtPhlowViewSelectorAccessor classSide >> defaultViewSelector [
	^ #gtViewsFor:
]

{ #category : #accessing }
TGtPhlowViewSelectorAccessor >> defaultViewSelector [
	^ self class defaultViewSelector.
]

{ #category : #initialization }
TGtPhlowViewSelectorAccessor >> initializeViewSelector [
	selector := self defaultViewSelector
]

{ #category : #accessing }
TGtPhlowViewSelectorAccessor >> selector [
	<return: #Symbol>
	^ selector
]

{ #category : #accessing }
TGtPhlowViewSelectorAccessor >> selector: aSymbol [
	self assertViewSelector: aSymbol.
	selector := aSymbol
]
