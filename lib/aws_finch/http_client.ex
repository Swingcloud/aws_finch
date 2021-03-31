defmodule AwsFinch.HttpClient do
  @moduledoc false
  alias Finch.Response

  @type http_method :: :get | :post | :put | :delete
  @callback request(
              method :: http_method,
              url :: binary,
              req_body :: binary,
              headers :: [{binary, binary}, ...],
              http_opts :: term
            ) ::
              {:ok, %{status_code: pos_integer, headers: any}}
              | {:ok, %{status_code: pos_integer, headers: any, body: binary}}
              | {:error, %{reason: any}}
  def request(method, url, req_body, headers, http_opts) do
    case method
         |> Finch.build(url, headers, req_body)
         |> Finch.request(__MODULE__, http_opts) do
      {:ok, %Response{status: status_code, body: body, headers: headers}} ->
        {:ok, %{status_code: status_code, headers: headers, body: body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
