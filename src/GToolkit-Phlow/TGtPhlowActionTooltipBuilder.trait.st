Trait {
	#name : #TGtPhlowActionTooltipBuilder,
	#traits : 'TGtPhlowTooltipBuilder',
	#category : #'GToolkit-Phlow-Tooltip'
}

{ #category : #'building tooltip' }
TGtPhlowActionTooltipBuilder >> attachTooltipFor: anElement hostElement: aTargetElement [
	self tooltipBuilder applyOn: anElement hostElement: aTargetElement
]
