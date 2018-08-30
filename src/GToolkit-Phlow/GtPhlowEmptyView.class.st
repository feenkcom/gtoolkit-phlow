"
I represent an empty view that does not do anything when being asked to create an element.

I am used to override an existing view.
"
Class {
	#name : #GtPhlowEmptyView,
	#superclass : #GtPhlowViewDecorator,
	#category : 'GToolkit-Phlow'
}

{ #category : #accessing }
GtPhlowEmptyView >> asElementDo: aBlock [
	"do nothing"
]

{ #category : #converting }
GtPhlowEmptyView >> asTaskItView [
	"We do not TaskIt empty view"
	^ self
]

{ #category : #converting }
GtPhlowEmptyView >> ifItHasContent: aBlock [
	"do nothing"
]
