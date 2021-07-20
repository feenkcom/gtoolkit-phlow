Class {
	#name : 'GtPhlowSingleViewBuilder',
	#superclass : 'GtPhlowViewBuilder',
	#traits : 'TGtPhlowViewSelectorAccessor',
	#classTraits : 'TGtPhlowViewSelectorAccessor classTrait',
	#category : 'GToolkit-Phlow-Collectors'
}

{ #category : 'building' }
GtPhlowSingleViewBuilder >> buildView [
	<return: #GtPhlowCompositeView>
	^ self object perform: self selector with: self view
]

{ #category : 'initialization' }
GtPhlowSingleViewBuilder >> initialize [
	super initialize.
	self initializeViewSelector.
]
