defmodule GildedRose do
 
  @backstage_passes ["Backstage passes to a TAFKAL80ETC concert"]
  @apreciators @backstage_passes ++ ["Aged Brie"]
  @conjured_items ["Spellbook"]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(item = %Item{sell_in: sell_in, quality: quality}) do
    %Item{
      item |
        quality: update(:quality, quality, quality(item)),
        sell_in: update(:sell_in, sell_in, sell_in(item))
    }
  end

  defp update(:quality, value, :noop), do: value
  defp update(:quality, _value, :zero), do: 0
  defp update(:quality, value, op), do: (value + op) |> min(50) |> max(0)

  defp update(:sell_in, value, :noop), do: value
  defp update(:sell_in, value, op), do: (value + op) 

  defp quality(%Item{name: "Sulfuras, Hand of Ragnaros"}), do: :noop 
  defp quality(%Item{name: name}) when name in @conjured_items, do: -2
  defp quality(%Item{name: name, sell_in: sell_in}) when name in @backstage_passes and sell_in <= 0, do: :zero
  defp quality(%Item{name: name, sell_in: sell_in}) when name in @backstage_passes and sell_in <= 5, do: 3
  defp quality(%Item{name: name, sell_in: sell_in}) when name in @backstage_passes and sell_in <= 10, do: 2
  defp quality(%Item{name: name}) when name in @apreciators, do: 1 
  defp quality(%Item{sell_in: sell_in, quality: quality}) when sell_in <= 0 and quality > 0, do: -2
  defp quality(%Item{quality: quality}) when quality > 0, do: -1
  defp quality(%Item{}), do: :noop

  defp sell_in(%Item{name: "Sulfuras, Hand of Ragnaros"}), do: :noop
  defp sell_in(%Item{}), do: -1
end
