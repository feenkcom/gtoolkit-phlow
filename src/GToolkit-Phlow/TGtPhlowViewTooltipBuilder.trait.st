Trait {
	#name : #TGtPhlowViewTooltipBuilder,
	#traits : 'TGtPhlowTooltipBuilder',
	#classTraits : 'TGtPhlowTooltipBuilder classTrait',
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #'building tooltip' }
TGtPhlowViewTooltipBuilder >> attachTooltipFor: anElement [
	self tooltipBuilder applyOn: anElement
]
