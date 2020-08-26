# YamlFrontMatter

[![Hex.pm](https://img.shields.io/hexpm/v/yaml_front_matter.svg)](https://hex.pm/packages/yaml_front_matter)
[![Hex.pm](https://img.shields.io/hexpm/dt/yaml_front_matter.svg)](https://hex.pm/packages/yaml_front_matter)
[![Travis](https://img.shields.io/travis/sebastiandedeyne/yaml_front_matter.svg)](https://travis-ci.org/sebastiandedeyne/yaml_front_matter)

Parse a file or string containing front matter and a document body. 
  
Front matter is a block of yaml wrapped between two lines containing `---`.
In this example, the front matter contains `title: Hello`, and the body is
`Hello, world`:

```md
---
title: Hello
---
Hello, world
```

After parsing the document, front matter is returned as a map, and the body as
a string.

```elixir
YamlFrontMatter.parse_file "hello_world.md"
{:ok, %{"title" => "Hello"}, "Hello, world"}    
```

## Installation

Add `yaml_front_matter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:yaml_front_matter, "~> 1.0.0"}]
end
```

Ensure `yaml_front_matter` is started before your application:

```elixir
def application do
  [applications: [:yaml_front_matter]]
end
```

## Usage

See [https://hexdocs.pm/yaml_front_matter/](https://hexdocs.pm/yaml_front_matter/)

## Changelog

Please see [CHANGELOG](https://github.com/sebastiandedeyne/yaml_front_matter/blob/master/CHANGELOG.md) for more information what has changed recently.

## Testing

```bash
$ mix test
```

## Contributing

Pull requests are welcome!

## Credits

- [Sebastian De Deyne](https://github.com/sebastiandedeyne)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please check the [LICENSE](https://github.com/sebastiandedeyne/yaml_front_matter/blob/master/LICENSE.md) for more information.
