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
    
    {:ok, matter, body} = YamlFrontMatter.parse_string string

    assert Map.size(matter) == 1
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
    
    {:ok, matter, body} = YamlFrontMatter.parse_string string

    assert Map.size(matter) == 1
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
    
    {:error, _} = YamlFrontMatter.parse_string string
  end

  test "it fails safely if there's no valid front matter" do
    string = """
    ---
    title: Hello
    --
    Hello, world
    """
    
    {:error, _} = YamlFrontMatter.parse_string string
  end

  test "it can parse front matter from a file" do
    {:ok, matter, body} = YamlFrontMatter.parse_file("test/fixtures/dummy.md")

    assert Map.size(matter) == 1
    assert matter["title"] == "Hello"
    assert body == "Hello, world\n"
  end
end