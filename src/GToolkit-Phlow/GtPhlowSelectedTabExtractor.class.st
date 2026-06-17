Class {
	#name : #GtPhlowSelectedTabExtractor,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtElementAssertion',
	#classTraits : 'TBlDebug classTrait + TGtElementAssertion classTrait',
	#instVars : [
		'inspectorElement'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'api - actions' }
GtPhlowSelectedTabExtractor >> extractTabName [
	<return: #GtPhlowTabName>
	self inspectorElement phlow
		firstChildWithCompositeViewContentDo: [ :tabGroup | 
			tabGroup viewModel hasSelectedTab 
				ifFalse: [ ^ GtPhlowTabName null ].
		
			^ tabGroup viewModel selectedTab widget
				phlow entity 
					ifNotNil: [ :aPhlow | 
						GtPhlowTabName new 
							string: aPhlow title asString ]
					ifNil: [ GtPhlowTabName null ] ].
	^ GtPhlowTabName null
]

{ #category : #accessing }
GtPhlowSelectedTabExtractor >> inspectorElement [
	<return: #GtInspector>
	^ inspectorElement
]

{ #category : #accessing }
GtPhlowSelectedTabExtractor >> inspectorElement: aGtInspector [
	self assertElement: aGtInspector.
	inspectorElement := aGtInspector
]
