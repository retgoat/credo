defmodule Credo.ExecutionTest do
  use ExUnit.Case

  alias Credo.Execution

  test "it should work for prepend_task/4" do
    exec = %Execution{
      pipeline_map: %{
        Execution => [
          parse_cli_options: [
            {Credo.Execution.Task.ParseOptions, []}
          ],
          validate_cli_options: [
            {Credo.Execution.Task.ValidateOptions, []}
          ]
        ]
      }
    }

    expected_pipeline_map = %{
      Execution => [
        parse_cli_options: [
          {Credo.Execution.Task.ParseOptions, []}
        ],
        validate_cli_options: [
          {Credo.ExecutionTest, []},
          {Credo.Execution.Task.ValidateOptions, []}
        ]
      ]
    }

    result = Execution.prepend_task(exec, Credo, :validate_cli_options, Credo.ExecutionTest)

    assert expected_pipeline_map == result.pipeline_map
  end

  test "it should work for append_task/4" do
    exec = %Execution{
      pipeline_map: %{
        Execution => [
          parse_cli_options: [
            {Credo.Execution.Task.ParseOptions, []}
          ],
          validate_cli_options: [
            {Credo.Execution.Task.ValidateOptions, []}
          ]
        ]
      }
    }

    expected_pipeline_map = %{
      Execution => [
        parse_cli_options: [
          {Credo.Execution.Task.ParseOptions, []}
        ],
        validate_cli_options: [
          {Credo.Execution.Task.ValidateOptions, []},
          {Credo.ExecutionTest, []}
        ]
      ]
    }

    result = Execution.append_task(exec, Credo, :validate_cli_options, Credo.ExecutionTest)

    assert expected_pipeline_map == result.pipeline_map
  end
end
