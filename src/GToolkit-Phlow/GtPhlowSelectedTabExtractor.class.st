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
	<return: #GtInspectorTabName>
	self inspectorElement phlow
		firstChildWithCompositeViewContentDo: [ :tabGroup | 
			tabGroup viewModel hasSelectedTab 
				ifFalse: [ ^ GtInspectorTabName null ].
		
			^ tabGroup viewModel selectedTab widget
				phlow entity 
					ifNotNil: [ :aPhlow | 
						GtInspectorTabName new 
							string: aPhlow title asString ]
					ifNil: [ GtInspectorTabName null ] ].
	^ GtInspectorTabName null
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
