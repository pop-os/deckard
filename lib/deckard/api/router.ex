defmodule Deckard.Api.Router do
  @moduledoc """
  Common definitions for the API Router.
  """

  defmacro __using__(_opts) do
    quote do
      use Plug.Router
      use Plug.ErrorHandler

      require Logger

      import Plug.Conn

      alias Plug.Conn.Status

      plug Plug.RequestId
      plug :set_content_type

      plug LoggerJSON.Plug,
        metadata_formatter: LoggerJSON.Plug.MetadataFormatters.DatadogLogger

      plug CORSPlug

      plug :match

      plug Plug.Telemetry, event_prefix: [:deckard, :plug]

      plug Plug.Parsers, parsers: [:json], json_decoder: Jason
      plug :dispatch, builder_opts()

      def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
        formatted_reason = Exception.format(kind, reason)
        formatted_stack = Exception.format_stacktrace(stack)

        Logger.error(
          "Unexpected error handling API call" <>
            " method=#{conn.method}, path=#{conn.request_path}",
          kind: kind,
          reason: formatted_reason,
          stacktrace: formatted_stack
        )

        response = %{errors: [Status.reason_phrase(conn.status)]}
        send_resp(conn, conn.status, Jason.encode!(response)) |> halt()
      end

      def set_content_type(conn, _) do
        register_before_send(conn, &put_resp_content_type(&1, "application/json"))
      end

      defp send_json_resp(conn, status) when status in [404, :not_found] do
        body = %{errors: [Status.reason_phrase(404)]}
        send_json_resp(conn, status, body)
      end

      defp send_json_resp(conn, status, body) do
        send_resp(conn, status, Jason.encode!(body))
      end
    end
  end
end
