defmodule GildedRose do
  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item
    |> update_item_quality()
    |> update_item_sell_in()
  end

  @backstage_passes ["Backstage passes to a TAFKAL80ETC concert"]
  @apreciators @backstage_passes ++ ["Aged Brie"]
  @conjured_items ["Spellbook"]

  defp update_item_quality(item = %Item{name: "Sulfuras, Hand of Ragnaros"}), do: item

  defp update_item_quality(item = %Item{name: name, quality: quality}) when name in @conjured_items do
    %Item{item | quality: quality - 2}    
  end 

  defp update_item_quality(item = %Item{name: name, sell_in: sell_in}) 
    when name in @backstage_passes and sell_in <= 0 do
    %Item{item | quality: 0}
  end

  defp update_item_quality(item = %Item{name: name, sell_in: sell_in, quality: quality}) 
    when name in @backstage_passes and sell_in <= 5 do
    %Item{item | quality: min(quality + 3, 50)}
  end

  defp update_item_quality(item = %Item{name: name, sell_in: sell_in, quality: quality}) 
    when name in @backstage_passes and sell_in <= 10 do
    %Item{item | quality: min(quality + 2, 50)}
  end

  defp update_item_quality(item = %Item{name: name, quality: quality}) when name in @apreciators do
    %Item{item | quality: min(quality + 1, 50)}
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
end
