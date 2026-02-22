# Test Notifier

Display notifications when tests run. Supports Minitest and RSpec.

## Installation

```
gem install test_notifier
```

Check <https://github.com/fnando/notifier> to see how you can configure a
notifier for your OS.

## Usage

You can set the default notifier, in case you want to use an specific one.

```ruby
TestNotifier.default_notifier = :terminal_notifier
```

The available notifiers are `:terminal_notifier`, `:hud`, `:kdialog`,
`:knotify`, `:notify_send`, `:osd_cat`, and `:snarl`.

If you'd like to make Test Notifier optional for your project:

```ruby
TestNotifier.silence_no_notifier_warning = true
```

## Maintainer

- Nando Vieira - https://nandovieira.com

## Collaborators

https://github.com/fnando/test_notifier/graphs/contributors

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
