"
I am a basic Phlow context that can store key-value information.


"
Class {
	#name : #GtPhlowContext,
	#superclass : #GtPhlowExecutionContext,
	#traits : 'TGtOptions',
	#classTraits : 'TGtOptions classTrait',
	#category : 'GToolkit-Phlow-Context'
}

{ #category : #factory }
GtPhlowContext class >> null [
	^ GtPhlowNullContext default
]

{ #category : #accessing }
GtPhlowContext >> at: aKey [
	^ self optionAt: aKey ifPresent: #yourself ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPhlowContext >> at: aKey ifAbsentPut: aValuable [
	^ self optionAt: aKey ifAbsentPut: aValuable
]

{ #category : #accessing }
GtPhlowContext >> at: aKey put: aValue [
	^ self optionAt: aKey put: aValue
]
