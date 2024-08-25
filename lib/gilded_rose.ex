defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item
    |> update_item_quality()
    |> update_item_sell_in()
  end

  # Item Types
  # Normal Items
  # Backstage Passes
  # Sulfuras [Legendary Items] (never degrade in quality) 
  # Aged Brie (increases in quality)
  # Conjured Items


  defp update_item_quality(item = %Item{name: "Sulfuras, Hand of Ragnaros"}), do: item

  defp update_item_quality(item = %Item{name: "Aged Brie", quality: quality}) do
    %Item{item | quality: if(quality < 50, do: quality + 1, else: quality)}
  end

  defp update_item_quality(item = %Item{sell_in: sell_in, quality: quality})
       when sell_in <= 0 and quality > 0 do
    %Item{item | quality: max(quality - 2, 0)}
  end

  defp update_item_quality(item = %Item{quality: quality}) when quality > 0 do
    %Item{item | quality: quality - 1}
  end

  defp update_item_quality(item), do: item

  defp update_item_sell_in(item = %Item{name: "Sulfuras, Hand of Ragnaros"}), do: item

  defp update_item_sell_in(item = %Item{sell_in: sell_in}) do
    %Item{item | sell_in: sell_in - 1}
  end

  # def update_item(item) do
  #   item =
  #     cond do
  #
  #       # TODO: Refactor Degrade Quality logic
  #       item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
  #         if item.quality > 0 do
  #           if item.name != "Sulfuras, Hand of Ragnaros" do
  #             %{item | quality: item.quality - 1}
  #           else
  #             item
  #           end
  #         else
  #           item
  #         end
  #
  #       true ->
  #         cond do
  #           # TODO: Refactor Increase Quality if Quality is < 50 (max allowed) 
  #           item.quality < 50 ->
  #             item = %{item | quality: item.quality + 1}
  #
  #             cond do
  #
  #               # TODO: Refactor Backstage pass quality logic
  #               item.name == "Backstage passes to a TAFKAL80ETC concert" ->
  #                 item =
  #                   cond do
  #                     item.sell_in < 11 ->
  #                       cond do
  #                         item.quality < 50 ->
  #                           %{item | quality: item.quality + 1}
  #
  #                         true ->
  #                           item
  #                       end
  #
  #                     true ->
  #                       item
  #                   end
  #
  #                 cond do
  #                   item.sell_in < 6 ->
  #                     cond do
  #                       item.quality < 50 ->
  #                         %{item | quality: item.quality + 1}
  #
  #                       true ->
  #                         item
  #                     end
  #
  #                   true ->
  #                     item
  #                 end
  #
  #               true ->
  #                 item
  #             end
  #
  #           true ->
  #             item
  #         end
  #     end
  #
  #   item =
  #     cond do
  #       # TODO: Update sell in days ()
  #       item.name != "Sulfuras, Hand of Ragnaros" ->
  #         %{item | sell_in: item.sell_in - 1}
  #
  #       true ->
  #         item
  #     end
  #
  #   cond do
  #     item.sell_in < 0 ->
  #       cond do
  #         item.name != "Aged Brie" ->
  #           cond do
  #             item.name != "Backstage passes to a TAFKAL80ETC concert" ->
  #               cond do
  #                 item.quality > 0 ->
  #                   cond do
  #                     item.name != "Sulfuras, Hand of Ragnaros" ->
  #                       %{item | quality: item.quality - 1}
  #
  #                     true ->
  #                       item
  #                   end
  #
  #                 true ->
  #                   item
  #               end
  #
  #             true ->
  #               %{item | quality: item.quality - item.quality}
  #           end
  #
  #         true ->
  #           cond do
  #             item.quality < 50 ->
  #               %{item | quality: item.quality + 1}
  #
  #             true ->
  #               item
  #           end
  #       end
  #
  #     true ->
  #       item
  #   end
  # end
end
