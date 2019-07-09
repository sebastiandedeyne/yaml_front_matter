defmodule YamlFrontMatterTest do
  use ExUnit.Case
  doctest YamlFrontMatter

  test "it can parse front matter" do
    string = """
    ---
    title: Hello
    ---
    Hello, world
    """

    {:ok, matter, body} = YamlFrontMatter.parse(string)

    assert Kernel.map_size(matter) == 1
    assert matter["title"] == "Hello"
    assert body == "Hello, world\n"
  end

  test "it can parse front matter when there's a `---` in the body" do
    string = """
    ---
    title: Hello
    ---
    Hello
    ---
    world
    """

    {:ok, matter, body} = YamlFrontMatter.parse(string)

    assert Kernel.map_size(matter) == 1
    assert matter["title"] == "Hello"
    assert body == "Hello\n---\nworld\n"
  end

  test "it fails safely if a yaml parse error is raised" do
    string = """
    ---
    hurrr:
    durrr
    ---
    Hello, world
    """

    {:error, _} = YamlFrontMatter.parse(string)
  end

  test "it fails safely if there's no valid front matter" do
    string = """
    ---
    title: Hello
    --
    Hello, world
    """

    {:error, _} = YamlFrontMatter.parse(string)
  end
end
