# WildCamp

[![Coverage Status](https://coveralls.io/repos/github/mattonem/WildCamping/badge.svg?branch=master)](https://coveralls.io/github/mattonem/WildCamping?branch=master)
[![Continuous Integration (CI)](https://github.com/mattonem/WildCamping/actions/workflows/ci.yml/badge.svg)](https://github.com/mattonem/WildCamping/actions/workflows/ci.yml)
![Static Badge](https://img.shields.io/badge/Pharo%20Smalltalk-11-ff69b4)


WildCamp is html component implementation built with [PharoJS](https://github.com/PharoJS/PharoJS).

- The component parent class to be used is `WCComponent`. 
- The html structure of the component is to be defined in: `YourComponent>>#renderHtmlOn:`.

It uses an Html tag brush to build the html template (see `WCCHelloWorld` for an example). 

This initialization of the component (generating callbacks and other stuff) happens in the `YourComponent>>#start` method.

Components can be used statically as well as dynamically (`WCHelloWorldApp` give an example of an app using `WCCHelloWorld` as a static component).

## Live Examples
- [WCGeohashWebApp](https://mattonem.github.io/WCGeohashWebApp/) a [GeoHash](https://en.wikipedia.org/wiki/Geohash) implementation.
- [UBNameGenerator](https://mattonem.github.io/UBNameGenerator/) a *Ubuntu-like* name generator.
