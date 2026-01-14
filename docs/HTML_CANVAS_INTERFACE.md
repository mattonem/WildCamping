# HTML Canvas Interface Guide

## Overview

The **HTML Canvas Interface** is WildCamping's fluent, object-oriented API for generating HTML elements. It provides a clean, chainable syntax for building dynamic and static HTML using Pharo methods, making UI construction intuitive and maintainable.

## Core Concepts

### Canvas

The `WCHtmlCanvas` class is the entry point for all HTML generation. It provides a fluent API where each method returns a **brush** object that can be chained to build complex HTML structures.

```smalltalk
html div
    id: 'myDiv';
    class: 'container';
    with: 'Hello World'
```

### Brushes

Brushes are specialized objects that represent HTML elements. When you call a method on the canvas (like `div`, `span`, `button`), you get back a brush object that understands how to configure that element.

**Common brush methods:**
- `id:` - Sets the element's ID attribute
- `class:` - Adds CSS class(es)
- `with:` - Adds content (text or nested elements)
- `style:` - Inline CSS styles

## Basic Structure

### Simple Elements

```smalltalk
html div
    with: 'Simple text content'
```

### Elements with Attributes

```smalltalk
html button
    id: 'submitBtn';
    class: 'btn btn-primary';
    with: 'Submit'
```

### Nested Elements

Use blocks to nest elements:

```smalltalk
html div
    id: 'container';
    with: [
        html heading with: 'Title'.
        html paragraph with: 'Some content'.
        html button with: 'Click me'
    ]
```

## Available Tags

### Structural Tags

- `div` - Generic container
- `section` - Thematic grouping of content
- `span` - Inline container

### Text Tags

- `heading` - Header (h1-h6)
- `paragraph` - Paragraph
- `break` - Line break
- `horizontalRule` - Horizontal rule
- `preformatted` - Preformatted text
- `idiomatic` - Idiomatic text

### List Tags

- `unorderedList` - Unordered list
- `listItem` - List item

### Table Tags

- `table` - Table element
- `tableHead` - Table header section
- `tableBody` - Table body section
- `tableRow` - Table row
- `tableHeading` - Table header cell
- `tableColumn` - Table data cell

### Form Tags

- `form` - Form container
- `textInput` - Text input field
- `numberInput` - Number input
- `checkbox` - Checkbox input
- `fileInput` - File upload input
- `inputRange` - Range slider
- `textArea` - Multi-line text area
- `select` - Dropdown list
- `option` - Option in select
- `label` - Form label
- `button` - Button element
- `submitButton` - Submit button

### Media Tags

- `image` - Image element
- `canvas` - HTML5 canvas
- `svg` - SVG container
- `path` - SVG path element

### Other Tags

- `anchor` - Hyperlink
- `link` - External resource link
- `script` - Script element

## Attribute Setting

### Common Attributes

```smalltalk
html div
    id: 'myId';
    class: 'myClass otherClass';
    style: 'color: red; font-size: 14px;';
    with: 'Content'
```

### Data Attributes

```smalltalk
html div
    attributeAt: 'data-value' put: 42;
    with: 'Element with data attribute'
```

### Event Attributes

```smalltalk
html button
    onclick: 'alert("Clicked!")';
    with: 'Click me'
```

## Content Specification

### Text Content

```smalltalk
html paragraph
    with: 'Plain text content'
```

### HTML Content (Block)

```smalltalk
html div
    with: [
        html paragraph with: 'First paragraph'.
        html paragraph with: 'Second paragraph'
    ]
```

### Mixed Content

```smalltalk
html div
    with: [
        html text: 'Text before'.
        html paragraph with: 'Paragraph'.
        html text: 'Text after'
    ]
```

### Conditional Content

```smalltalk
html div
    with: [
        condition
            ifTrue: [ html paragraph with: 'True branch' ]
            ifFalse: [ html paragraph with: 'False branch' ]
    ]
```

## Component Integration

### Rendering Objects

Any object that implements `renderOn:` can be rendered through the canvas:

```smalltalk
html div
    with: (MyComponent new)
```

### Collection Rendering

Render collections of components:

```smalltalk
html unorderedList
    with: [
        items do: [ :item |
            html listItem with: (ItemComponent new item: item)
        ]
    ]
```

## Advanced Patterns

### Building Lists

```smalltalk
html unorderedList
    id: 'items';
    with: [
        #('Item 1' 'Item 2' 'Item 3') do: [ :item |
            html listItem with: item
        ]
    ]
```

### Building Tables

```smalltalk
html table
    id: 'dataTable';
    with: [
        html tableHead
            with: [
                html tableRow
                    with: [
                        html tableHeading with: 'Name'.
                        html tableHeading with: 'Age'
                    ]
            ].
        html tableBody
            with: [
                people do: [ :person |
                    html tableRow
                        with: [
                            html tableColumn with: person name.
                            html tableColumn with: person age asString
                        ]
                ]
            ]
    ]
```

### Building Forms

```smalltalk
html form
    with: [
        html label
            for: 'username';
            with: 'Username'.
        html textInput
            id: 'username';
            name: 'username'.
        
        html label
            for: 'password';
            with: 'Password'.
        html textInput
            id: 'password';
            name: 'password';
            type: 'password'.
        
        html submitButton with: 'Login'
    ]
```

### Building SVG

```smalltalk
html svg
    width: '100';
    height: '100';
    with: [
        html path
            d: 'M 10 10 H 90 V 90 H 10 Z';
            stroke: 'black';
            fill: 'none'
    ]
```

## Best Practices

### 1. Use Semantic HTML

```smalltalk
"Good: Semantic structure"
html section
    with: [
        html heading 
            level: 1; 
            with: 'Article Title'.
        html paragraph with: article text
    ]
```


### 2. Use Blocks for Complex Nesting

```smalltalk
"Good: Clear nesting with blocks"
html div
    with: [
        html heading with: 'Title'.
        html paragraph with: 'Content'
    ]

"Avoid: Excessive method chaining"
html div with: html heading with: 'Title'
```

### 3. Set IDs for JavaScript Access

```smalltalk
"Elements you plan to access from JavaScript should have IDs"
html button
    id: 'myButton';
    with: 'Click me'

"Later in start:"
(document getElementById: 'myButton') 
    addEventListener: 'click' 
    do: [ self handleClick ]
```

## Generic Tags

For tags not explicitly supported by the canvas, use `tag:`:

```smalltalk
html tag: 'article'
    with: 'Article content'.

html tag: 'details'
    with: [
        html tag: 'summary' with: 'More info'.
        html paragraph with: 'Details here'
    ]
```

## Integration with Components

In WildCamping components, use the passed canvas in `renderHtmlOn:`:

```smalltalk
MyComponent >> renderHtmlOn: html
    "html is a WCHtmlCanvas instance"
    html div
        id: self elementId;
        class: self cssClass;
        with: self content
```

Elements generated through the canvas are automatically tracked by the component's scoping mechanism, making them accessible via `getElementById:` in the `start` method.

