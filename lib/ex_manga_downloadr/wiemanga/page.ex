defmodule ExMangaDownloadr.WieManga.Page do
  require Logger
  require ExMangaDownloadr

  def image(page_link) do
    ExMangaDownloadr.fetch page_link, do: fetch_image
  end

  defp fetch_image(html) do
    html
    |> Floki.find("img#comicpic")
    |> Enum.map(fn(x) -> normalize_metadata(x, html); end)
    |> Enum.at(0)
  end

  defp normalize_metadata(line, html) do
    case line do
      {"img", [{"id", _}, {"name", _}, {"src", image_src}, {"onclick", _}, {"onmousemove", _}, {"alt", image_alt}, {"onload", _}, {"border", _}], _} ->
        extension      = String.split(image_src, ".") |> Enum.at(-1)
        title_name = html |> Floki.find(".sitemaplist")|> Floki.text |> String.split(">>") |> Enum.at(1) |> String.trim
        chapter_number = String.split(image_alt) |> Enum.at(1) |> String.rjust(5, ?0)
        page_title     = html |> Floki.find("title") |> Floki.text
        page_number    = Regex.run(~r/Page\ +(\d+)/, page_title) |> Enum.at(1)

        {image_src, "#{title_name} #{chapter_number} - Page #{page_number}.#{extension}"}
      _ -> nil
    end

  end
end
