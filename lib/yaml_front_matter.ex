defmodule YamlFrontMatter do
  @moduledoc """
  Parse a file or string containing front matter and a document body. Front 
  matter is a block of yaml wrapped between two lines containing `---`.

  In this example, the front matter contains `title: Hello`, and the body is
  `Hello, world`:

  ```
  ---
  title: Hello
  ---
  Hello, world
  ```

  After parsing the document, front matter is returned as a map, and the body as
  a string.

  ## Examples

  Returns `{:ok, matter, body}` on success

    iex> YamlFrontMatter.parse_file "test/fixtures/dummy.md"
    {:ok, %{"title" => "Hello"}, "Hello, world\\n"}

    iex> YamlFrontMatter.parse_string "---\\ntitle: Hello\\n---\\nHello, world"
    {:ok, %{"title" => "Hello"}, "Hello, world"}

  Returns `{:error, error}` on failure

    iex> YamlFrontMatter.parse_file "test/fixtures/idontexist.md"
    {:error, :enoent}

    iex> YamlFrontMatter.parse_string "---\\ntitle: Hello\\n--\\nHello, world"
    {:error, :invalid_front_matter}
  """

  def parse_file(path) do
    case File.read(path) do
      {:ok, contents} -> parse_string(contents)
      {:error, error} -> {:error, error}
    end
  end

  def parse_string(string) do
    string
    |> split_string
    |> process_parts
  end

  defp split_string(string) do
    split_pattern = ~r/[\s\r\n]---[\s\r\n]/s
    
    string
    |> (&String.trim_leading(&1)).()
    |> (&("\n" <> &1)).()
    |> (&Regex.split(split_pattern, &1, [parts: 3])).()
  end

  defp process_parts([_, yaml, body]) do
    case parse_yaml(yaml) do
      {:ok, yaml} -> {:ok, yaml, body}
      {:error, error} -> {:error, error}
    end
  end

  defp process_parts(_), do: {:error, :invalid_front_matter}

  defp parse_yaml(yaml) do
    try do
      {:ok, YamlElixir.read_from_string(yaml)}
    catch
      error -> {:error, error}
    end
  end
end
