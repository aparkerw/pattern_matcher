Pattern Matcher
============

Gem to help manage, test and run regex pattern matchers for a given project.

Gem can be found on rubygems at https://rubygems.org/gems/pattern_matcher


=========
**Code coverage for Ruby 1.9**

  * [Source Code]
  * [API documentation]

[Source Code]: https://github.com/aparker/pattern_matcher "Source Code @ GitHub"
[leak-stopper]: https://rubygems.org/gems/leak_stopper "LeakStopper"


PatternMatcher is a code tool that provides a framework for the storing, testing and running of common patterns.  It can be used
in a one-off fashion from the command line or can be included inside of your application.  The underlying code uses regular 
expression matching but provides more human readable responses when matches are found.

The intention is to provide structured management of system-wide matching strings that can then be easily reused and tested to 
ensure that intended behavior is maintained throughout the lifespan of the project.

PatternMatcher is a result of abstracting the core logic for the [leak-stopper] gem and, as a result has some behavior that, while generalized, is intended to assist the functionality that LeakStopper intended to provide.

Getting started (code)
---------------

1. Add pattern_matcher to your `Gemfile` and `bundle install`:

2. Initialize Pattern pattern_matcher

```ruby
	PatternMatcher.configure do |config|
      config.patterns_yml = File.join(File.dirname(__FILE__), "config", "patterns.yml")
    end
```

3. Call `match_patterns_to_text` to get a list of `PatternMatcher::Match` objects

```ruby
	matches = PatternMatcher.match_patterns_to_text(some_text)
	matches.each do |match|
		puts match.to_s
	end
```

Getting started (command line)
---------------

1. download pattern_matcher by calling `gem install pattern_matcher`:

```ruby
	gem 'simplecov', :require => false, :group => :test
```

## Example patterns.yml File

The `patterns.yml` file is where patterns can be defined and maintained.  It looks like this:

```
patterns:
  SSN:
    name: Social Security Number
    regex: '[0-9]{3}-[0-9]{2}-[0-9]{4}'
    description: Social Security Numbers.
    valid_examples: ['111-22-1111', '222-11-2222']
  UserDID:
    name: Seven Digit Phone Number
    regex: '[0-9]{3}-[0-9]{4}'
    description: A seven digit US phone number.
    valid_examples: ['111-1234', '867-5309']
```

**Pattern Key** - Below the patterns node is the Pattern Key.  This must be unique and identifies the pattern described below.

**name** - The descriptitive title for the type of pattern this is.

**regex** - A regular expression describing the pattern that is to be matched.  This is a _required_ part of the pattern and is
used directly to identify matches within analyzed text.

**description** - A detailed description of what the pattern is.

**valid_examples** - A list of known matches that the system can test the regex pattern against to ensure expected behavior.

**Coverage results report, fully browsable locally with sorting and much more:**


#### The PatternMatcher::Match object


Note here


#### Configuration

Note here


#### Debugging Patterns

A core role of PatternMatcher is to help maintain the patterns that are important to you.  This means making them easy to see and understand along with being able to have confidence that they are behaving as expected.


## List/Report Known Patterns

**.patterns**

**.to_s**

**.to_s a pattern**


## Validate Patterns