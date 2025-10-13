Class {
	#name : #PackageManifestGToolkitPhlowModel,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Phlow-Model-Manifest'
}

{ #category : #asserting }
PackageManifestGToolkitPhlowModel class >> mustNotDependOn [
	^ {'GToolkit-Phlow'.
		'Bloc'.
		'Brick'}
]
