Trait {
	#name : #TGtPhlowActionTooltipBuilder,
	#traits : 'TGtPhlowTooltipBuilder',
	#classTraits : 'TGtPhlowTooltipBuilder classTrait',
	#category : 'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #'building tooltip' }
TGtPhlowActionTooltipBuilder >> attachTooltipFor: anElement hostElement: aTargetElement [
	self tooltipBuilder applyOn: anElement hostElement: aTargetElement
]
