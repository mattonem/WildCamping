# WildCamping

[![Coverage Status](https://coveralls.io/repos/github/mattonem/WildCamping/badge.svg?branch=master)](https://coveralls.io/github/mattonem/WildCamping?branch=master)
[![Continuous Integration (CI)](https://github.com/mattonem/WildCamping/actions/workflows/ci.yml/badge.svg)](https://github.com/mattonem/WildCamping/actions/workflows/ci.yml)
![Static Badge](https://img.shields.io/badge/Pharo%20Smalltalk-11-ff69b4)

A web component framework for building interactive web applications in [Pharo Smalltalk](https://pharo.org/). WildCamping leverages [PharoJS](https://github.com/PharoJS/PharoJS) to transpile Smalltalk code to JavaScript, enabling you to write full-stack web applications entirely in Pharo.

## Overview

WildCamping is a component-oriented framework that bridges the gap between server-side Smalltalk logic and client-side web interfaces. It provides an elegant, object-oriented approach to building interactive web applications with automatic JavaScript generation and encapsulated component architecture.

## Core Features

- **Object-Oriented HTML Generation**: Build dynamic and static HTML using a canvas-based API with full OO encapsulation
- **Automatic JavaScript Generation**: Write your component logic in Pharo and automatically generate optimized JavaScript for browser execution
- **Reusable Components**: Encapsulated, composable components with clear separation of concerns and lifecycle management
- **Dynamic Updates**: Support for interactive components that respond to user events and update dynamically without page reloads
- **WebWorker Integration**: Leverage browser WebWorkers via the Job interface for offloading compute-intensive tasks (WIP)

## Getting Started

### Component Lifecycle

The framework centers around the `WCComponent` base class. Each component goes through three key phases:

1. **Instance Setup** (`initialize`): Initialize your component's instance variables, models, and state
2. **HTML Structure** (`renderHtmlOn:`): Define your component's HTML template using the canvas-based tag brush API
3. **Event Initialization** (`start`): Set up callbacks, event handlers, and initialize dynamic behavior

Example:

```smalltalk
WCCHelloWorld >> renderHtmlOn: html
    html div
        id: 'hello';
        with: 'Hello, World!'

WCCHelloWorld >> start
    "Initialize callbacks and event handlers here"
```

## Examples

- [WCGeohashWebApp](https://mattonem.github.io/WCGeohashWebApp/): A [GeoHash](https://en.wikipedia.org/wiki/Geohash) implementation demonstrating spatial indexing
- [UBNameGenerator](https://mattonem.github.io/UBNameGenerator/): An Ubuntu-like name generator showcasing dynamic component interaction

## Architecture

WildCamping provides an abstraction layer over HTML and DOM manipulation:

- **Tag Brush Canvas API**: Fluent, object-oriented interface for building HTML with method chaining (e.g., `html div class: 'container'; with: [...]`)
- **Component Tree**: Hierarchical component composition where components can contain other components, enabling complex UIs through simple building blocks
- **PharoJS Transpilation**: Automatic and transparent conversion of Pharo methods to optimized JavaScript for browser execution
- **Event System**: Declarative event binding with automatic callback management and state synchronization

## Why WildCamping?

- **Unified Language**: Write frontend and backend logic in Pharo without JavaScript
- **Productive Development**: Leverage Smalltalk's interactive development environment and powerful IDE features
- **Maintainability**: Object-oriented architecture makes large applications easier to understand and maintain
- **Testability**: Comprehensive testing facilities built into Pharo and the framework (WIP)
- **Composability**: Build complex UIs from simple, reusable components
