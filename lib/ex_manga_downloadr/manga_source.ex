defmodule ExMangaDownloadr.MangaSource do
  @callback applies?(source :: String.t) :: boolean()
  @callback index_page(url :: String.t) :: {String.t, [...]}
  @callback chapter_page(page_link :: String.t) :: {:ok, any}
  @callback page_image(page_link :: String.t) :: {:ok, any}

  defstruct [:url, :module]

  def for(url) do
    case module_for(url) do
      :invalid -> :error
      module -> {:ok, %__MODULE__{url: url, module: module}}
    end
  end

  defp module_for(url) do
    :ex_manga_downloadr
    |> Application.get_env(:sources)
    |> Enum.find(:invalid, & &1.applies?(url))
  end
end
