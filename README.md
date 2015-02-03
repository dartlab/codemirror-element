# \<code-mirror\>

[![Build Status](https://drone.io/github.com/dartlab/codemirror-element/status.png)](https://drone.io/github.com/dartlab/codemirror-element/latest)

This Polymer element wraps the [CodeMirror text editor](http://codemirror.net).

## Demo

[Check it live!](http://dartlab.org/codemirror-element/simple_example.html)

## Install

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  codemirror_element: any
```

You can install packages from the command line:

```sh
$ pub get
```

## Usage

1. Import Custom Element:

  ```html
  <link rel="import" href="packages/codemirror_element/codemirror.html">
  ```

2. Start using it!

  ```html
  <code-mirror></code-mirror>
  ```

## Options

Attribute     | Options     | Default      | Description
---           | ---         | ---          | ---
`value`       | *string*    |              | The value of the editor.
`mode`        | *string*    |              | The [mode](http://codemirror.net/mode/index.html) to use.
`theme`       | *string*    |              | The [theme](http://codemirror.net/theme/) to style the editor with.
`lineNumbers` | *bool*      |   `false`    | Whether to show line numbers to the left of the editor.
`indentWithTabs`| *bool*    |   `false`    | Whether, when indenting, the first N*tabSize spaces should be replaced by N tabs.
`autoCloseTags` | *bool*    |   `false`    | Defines an autoCloseTags option that will auto-close XML tags when '>' or '/' is typed.

## Methods

Method        | Parameters   | Returns     | Description
---           | ---          | ---         | ---
`focus()`     | None.        | Nothing.    | Give the editor focus.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

For detailed changelog, check [CHANGELOG](https://github.com/dartlab/codemirror-element/blob/master/CHANGELOG.md).

## License

[BSD license](https://github.com/dartlab/codemirror-element/blob/master/LICENSE)