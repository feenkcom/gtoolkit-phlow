Class {
	#name : #GtPhlowUpdateLabelledViewTitle,
	#superclass : #GtPhlowUpdateCommand,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #evaluating }
GtPhlowUpdateLabelledViewTitle >> execute [
	<return: #GtPhlowLabelledView>
	self scheduleValuable: [
		self updateLabel ].
	^ self elementContext entity
]

{ #category : #updating }
GtPhlowUpdateLabelledViewTitle >> updateLabel [
	| aTitle |
	aTitle := GtPhlowLabelledViewBuilder titleOfObject: self object.
	self elementContext entity label: aTitle.
	self elementContext element viewModel tabs ifNotEmpty: [ :theTabModels | 
		theTabModels anyOne widgetDo: [ :aTab | aTab label: aTitle ] ]
]
