"
I display a label tooltip.
If a user clicks on the action, a defining method is displayed.


"
Class {
	#name : #GtPhlowLabelTooltipAptitude2,
	#superclass : #BrGlamorousWithExplicitTooltipAptitude,
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #'private - instance creation' }
GtPhlowLabelTooltipAptitude2 >> newMenuModelWithLabel: aLabelString shortcut: aShortcutString [
	| aMenuModel aDecoratingModel |
	aMenuModel := super
			newMenuModelWithLabel: aLabelString
			shortcut: aShortcutString.
	aDecoratingModel := BrMenuDecoratoringModel new
			menuModel: aMenuModel;
			decorator: [ :aMenuElement | 
				aMenuElement
					when: BlClickEvent
					do: [ :anEvent | 
						self widgetDo: [ :aWidget | 
							aWidget phlow spawnDefiningMethod ] ] ].
	^ aDecoratingModel
]
