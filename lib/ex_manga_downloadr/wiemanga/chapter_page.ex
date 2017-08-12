defmodule ExMangaDownloadr.WieManga.ChapterPage do
  require Logger
  require ExMangaDownloadr

  def pages(chapter_link) do
    ExMangaDownloadr.fetch chapter_link, do: fetch_pages
  end

  defp fetch_pages(html) do
    html
    |> Floki.find("select[id='page'] option")
    |> Floki.attribute("value")
  end
end
