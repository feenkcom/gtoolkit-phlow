"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPhlow,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Phlow-Manifest'
}

{ #category : #'code-critics' }
ManifestGToolkitPhlow class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GtPhlowView #performSecurely:on: #false)) #'2018-08-10T16:44:21.086354-04:00') #(#(#RGClassDefinition #(#GtPhlowViewExamples)) #'2018-08-10T17:05:22.387313-04:00') )
]
