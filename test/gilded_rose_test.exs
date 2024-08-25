defmodule GildedRoseTest do
  use ExUnit.Case

  describe "Normal items" do
    test "quality decreases by 1 before sell date" do
      items = [%Item{name: "Normal Item", sell_in: 5, quality: 10}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == 4
      assert updated_item.quality == 9
    end

    test "quality decreases by 2 after sell date" do
      items = [%Item{name: "Normal Item", sell_in: 0, quality: 10}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == -1
      assert updated_item.quality == 8
    end

    test "quality is never negative" do
      items = [%Item{name: "Normal Item", sell_in: 5, quality: 0}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.quality == 0
    end
  end

  describe "Aged Brie" do
    test "increases in quality" do
      items = [%Item{name: "Aged Brie", sell_in: 5, quality: 10}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == 4
      assert updated_item.quality == 11
    end

    test "quality is never more than 50" do
      items = [%Item{name: "Aged Brie", sell_in: 5, quality: 50}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.quality == 50
    end
  end

  describe "Sulfuras, Hand of Ragnaros" do
    test "never decreases in quality" do
      items = [%Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 80}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.quality == 80
    end

    test "never has to be sold, so never change the sellin days" do
      items = [%Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 80}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == 10
    end
  end

  describe "Backstage passes" do
    test "increase in quality by 1 when more than 10 days" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == 14
      assert updated_item.quality == 21
    end

    test "increase in quality by 2 when 10 days or less" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 20}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == 9
      assert updated_item.quality == 22
    end

    test "increase in quality by 3 when 5 days or less" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 20}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == 4
      assert updated_item.quality == 23
    end

    test "quality drops to 0 after concert" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 20}]
      [updated_item] = GildedRose.update_quality(items)
      assert updated_item.sell_in == -1
      assert updated_item.quality == 0
    end
  end

  describe "Multiple items" do
    test "can be updated" do
      items = [
        %Item{name: "Normal Item", sell_in: 5, quality: 10},
        %Item{name: "Aged Brie", sell_in: 3, quality: 10}
      ]

      updated_items = GildedRose.update_quality(items)
      assert length(updated_items) == 2
      assert Enum.at(updated_items, 0).quality == 9
      assert Enum.at(updated_items, 1).quality == 11
    end
  end
end
