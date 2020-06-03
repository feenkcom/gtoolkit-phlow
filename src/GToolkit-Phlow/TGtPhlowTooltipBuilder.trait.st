"
I add a tooltip option to a ${class:GtPhlowAction}$.
"
Trait {
	#name : #TGtPhlowTooltipBuilder,
	#instVars : [
		'tooltipBuilder'
	],
	#category : #'GToolkit-Phlow-Tooltip'
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
