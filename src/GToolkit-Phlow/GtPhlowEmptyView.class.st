"
I represent an empty view that does not do anything when being asked to create an element.

I am used to override an existing view.
"
Class {
	#name : #GtPhlowEmptyView,
	#superclass : #GtPhlowViewDecorator,
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowEmptyView >> asElementDo: aBlock [
	"do nothing. return an empty element just in case someone mistankenly relies on the return"
	^ BlElement new
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
