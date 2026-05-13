"
I add a tooltip option to a {{gtClass:GtPhlowAction}}.

"
Trait {
	#name : #TGtPhlowTooltipBuilder,
	#instVars : [
		'tooltipBuilder'
	],
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #defaults }
TGtPhlowTooltipBuilder >> defaultTooltipBuilder [
	^ GtPhlowTooltipBuilder null
]

{ #category : #initialization }
TGtPhlowTooltipBuilder >> initializeTooltipBuilder [
	tooltipBuilder := self defaultTooltipBuilder
]

{ #category : #'api - tooltip' }
TGtPhlowTooltipBuilder >> tooltip: aText [
	self tooltipBuilder: (GtPhlowTooltipBuilder text: aText)
]

{ #category : #'api - tooltip' }
TGtPhlowTooltipBuilder >> tooltipBuilder [
	^ tooltipBuilder
]

{ #category : #'api - tooltip' }
TGtPhlowTooltipBuilder >> tooltipBuilder: anObject [
	tooltipBuilder := anObject
]
