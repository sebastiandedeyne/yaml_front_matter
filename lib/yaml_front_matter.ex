defmodule YamlFrontMatter do
  @moduledoc """
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
  """

  @doc """
  Read a file, parse it's contents, and return it's front matter and body.

  Returns `{:ok, matter, body}` on success (`matter` is a map), or
  `{:error, error}` on error.

      iex> YamlFrontMatter.parse_file "test/fixtures/dummy.md"
      {:ok, %{"title" => "Hello"}, "Hello, world\\n"}

      iex> YamlFrontMatter.parse_file "test/fixtures/idontexist.md"
      {:error, :enoent}
  """
  def parse_file(path) do
    case File.read(path) do
      {:ok, contents} -> parse(contents)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Read a file, parse it's contents, and return it's front matter and body.

  Returns `{matter, body}` on success (`matter` is a map), throws on error.

      iex> YamlFrontMatter.parse_file! "test/fixtures/dummy.md"
      {%{"title" => "Hello"}, "Hello, world\\n"}

      iex> try do
      ...>   YamlFrontMatter.parse_file! "test/fixtures/idontexist.md"
      ...> rescue
      ...>   e in YamlFrontMatter.Error -> e.message
      ...> end
      "File not found"

      iex> try do
      ...>   YamlFrontMatter.parse_file! "test/fixtures/invalid.md"
      ...> rescue
      ...>   e in YamlFrontMatter.Error -> e.message
      ...> end
      "Error parsing yaml front matter"
  """
  def parse_file!(path) do
    case parse_file(path) do
      {:ok, matter, body} -> {matter, body}
      {:error, :enoent} -> raise YamlFrontMatter.Error, message: "File not found"
      {:error, _} -> raise YamlFrontMatter.Error
    end
  end

  @doc """
  Parse a string and return it's front matter and body.

  Returns `{:ok, matter, body}` on success (`matter` is a map), or
  `{:error, error}` on error.

      iex> YamlFrontMatter.parse "---\\ntitle: Hello\\n---\\nHello, world"
      {:ok, %{"title" => "Hello"}, "Hello, world"}

      iex> YamlFrontMatter.parse "---\\ntitle: Hello\\n--\\nHello, world"
      {:error, :invalid_front_matter}
  """
  def parse(string) do
    string
    |> split_string
    |> process_parts
  end

  @doc """
  Parse a string and return it's front matter and body.

  Returns `{matter, body}` on success (`matter` is a map), throws on error.

      iex> YamlFrontMatter.parse! "---\\ntitle: Hello\\n---\\nHello, world"
      {%{"title" => "Hello"}, "Hello, world"}

      iex> try do
      ...>   YamlFrontMatter.parse! "---\\ntitle: Hello\\n--\\nHello, world"
      ...> rescue
      ...>   e in YamlFrontMatter.Error -> e.message
      ...> end
      "Error parsing yaml front matter"
  """
  def parse!(string) do
    case parse(string) do
      {:ok, matter, body} -> {matter, body}
      {:error, _} -> raise YamlFrontMatter.Error
    end
  end

  defp split_string(string) do
    split_pattern = ~r/[\s\r\n]---[\s\r\n]/s

    string
    |> (&String.trim_leading(&1)).()
    |> (&("\n" <> &1)).()
    |> (&Regex.split(split_pattern, &1, parts: 3)).()
  end

  defp process_parts([_, yaml, body]) do
    case parse_yaml(yaml) do
      {:ok, yaml} -> {:ok, yaml, body}
      {:error, error} -> {:error, error}
    end
  end

  defp process_parts(_), do: {:error, :invalid_front_matter}

  defp parse_yaml(yaml) do
    case YamlElixir.read_from_string(yaml) do
      {:ok, parsed} -> {:ok, parsed}
      error -> error
    end
  end
end
