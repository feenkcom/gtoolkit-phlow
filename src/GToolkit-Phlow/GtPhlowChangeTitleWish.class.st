"
I am {{gtClass:BrWish}}.
I am an abstract class.
I notify {{gtClass:BlElement}} that a title should be changed.
The title can be composed of an {{gtMethod:GtPhlowChangeTitleWish>>#iconDo:|label=icon}} and a {{gtMethod:GtPhlowChangeTitleWish>>#labelDo:|label=label}}.
1. # Collaborators

{{gtClass:GtPhlowTitleNotifier}} fires instances of my subclasses.
1. # Other information

See my {{gtClass:GtPhlowChangeTitleWish|show=#gtSubclassesFor:|label=subclasses|expanded=true|height=130}} for specific examples:
1. # Examples

See {{gtClass:GtPhlowTitleNotifier|show=#gtSubclassesFor:|expanded=true|height=130}} subclasses for specific examples:


"
Class {
	#name : #GtPhlowChangeTitleWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> icon [
	^ nil
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> iconDo: aBlock [
	self icon 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: BrGlamorousVectorIcons noIcon ]
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> label [
	^ nil
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> labelDo: aBlock [
	self label 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: '' ]
]

{ #category : #sending }
GtPhlowChangeTitleWish >> sendTo: anObject [
	anObject changeTitleWish: self
]
