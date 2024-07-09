# gamefic-overlookable

A Gamefic library for easy implementation of insignificant entities.

It's good practice to implement nouns that players receive in descriptions, even if they're irrelevant to the game.

Bad:

    > look around

    You're in a room with four walls.

    > examine walls

    I recognize "examine" as a verb but don't know what you mean by "walls."

Better:

    > examine walls

    There's nothing special about the four walls.

The `gamefic-overlookable` library simplifies the process of creating `Scenery` entities that provide a default response to unimplemented nouns.

## Installation

Add the library to your Gamefic project's Gemfile:

```
gem 'gamefic-overlookable'
```

Run `bundle install`.

Add the requirement to your project's code (typically in `main.rb`):

```
require 'gamefic-overlookable'
```

## Usage

Entities gain an `overlook` method that lets you easily add scenery with a default description.

```ruby
MyGame.seed do
    @room = make Room, name: 'room', description: "You're in a room with four walls."
    @room.overlook 'four walls'
end
```

    > look around

    You're in a room with four walls.

    > examine walls

    There's nothing special about the four walls.

The `overlook` method can also accept multiple names:

```ruby
MyGame.seed do
    @room = make Room, name: 'room', description: 'A room with a tall ceiling and a wooden floor.'
    @room.overlook 'tall ceiling', 'wooden floor'
end
```

Separate names from synonyms with two slashes:

```ruby
MyGame.seed do
    @room = make Room, name: 'room', description: 'A room with a tall ceiling and a dark wooden floor.'
    @room.overlook 'ceiling//tall', 'floor//dark wooden'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/castwide/gamefic-overlookable.
