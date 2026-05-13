Class {
	#name : #GtPhlowToolDisableUpdatesWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #sending }
GtPhlowToolDisableUpdatesWish >> sendTo: anObject [
	^ anObject phlowToolDisableUpdatesWish: self
]
