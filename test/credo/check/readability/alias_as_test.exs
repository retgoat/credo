defmodule Credo.Check.Readability.AliasAsTest do
  use Credo.TestHelper

  @described_check Credo.Check.Readability.AliasAs

  test "it should NOT report violation" do
    """
    defmodule Test do
      alias App.Module1
      alias App.Module2
    end
    """
    |> to_source_file
    |> refute_issues(@described_check)
  end

  test "it should report a violation" do
    [issue] =
      """
      defmodule Test do
        alias App.Module1, as: M1
      end
      """
      |> to_source_file
      |> assert_issue(@described_check)

    assert issue.trigger == "App.Module1"
  end

  test "it should report multiple violations" do
    [issue1, issue2, issue3] =
      """
      defmodule Test do
        alias App.Module1, as: M1
        alias App.Module2
        alias App.Module3, as: M3
        alias App.Module4, as: M4
      end
      """
      |> to_source_file
      |> assert_issues(@described_check)

    assert issue1.trigger == "App.Module1"
    assert issue2.trigger == "App.Module3"
    assert issue3.trigger == "App.Module4"
  end
end
