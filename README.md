# YamlFrontMatter

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

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add `yaml_front_matter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:yaml_front_matter, "~> 0.1.0"}]
end
```

2. Ensure `yaml_front_matter` is started before your application:

```elixir
def application do
  [applications: [:yaml_front_matter]]
end
```

## Usage

See [https://hexdocs.pm/yaml_front_matter](https://hexdocs.pm/yaml_front_matter)

 ## Changelog
 
 Please see [CHANGELOG](CHANGELOG.md) for more information what has changed recently.
 
 ## Testing
 
 ``` bash
 $ mix test
 ```

## Contributing

Pull requests are welcome!

## Credits

- [Sebastian De Deyne](https://github.com/sebdedeyne)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
