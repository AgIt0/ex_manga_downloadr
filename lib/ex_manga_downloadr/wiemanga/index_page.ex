defmodule ExMangaDownloadr.WieManga.IndexPage do
  require Logger
  require ExMangaDownloadr

  def chapters(manga_root_url) do
    ExMangaDownloadr.fetch manga_root_url, do: collect
  end

  defp collect(html) do
    {fetch_manga_title(html), fetch_chapters(html)}
  end

  defp fetch_manga_title(html) do
    html
    |> Floki.find(".bookmessagebox h1")
    |> Floki.text
  end

  defp fetch_chapters(html) do
    html
    |> Floki.find(".chapterlist a")
    |> Floki.attribute("href")
  end
end
