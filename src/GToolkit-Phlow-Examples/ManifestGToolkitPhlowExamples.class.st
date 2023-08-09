"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPhlowExamples,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Phlow-Examples-Manifest'
}

{ #category : #testing }
ManifestGToolkitPhlowExamples class >> shouldValidateBaseline [
	^ true
]
