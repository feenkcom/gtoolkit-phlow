"
I wrap a forwarded object for the {{gtClass:GtPhlowForwarderView}}.
We wrap the object to support forwarding to the low level objects of the futures framework.
"
Class {
	#name : #GtPhlowForwardedObject,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowForwardedObject >> object [

	^ object
]

{ #category : #accessing }
GtPhlowForwardedObject >> object: anObject [

	object := anObject
]
