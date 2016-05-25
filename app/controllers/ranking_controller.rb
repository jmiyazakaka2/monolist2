class RankingController < ApplicationController
  before_action :ranking_number

  def have
    @title = "Haveランキング"
    @items = Have.group(:item_id).order('count_item_id desc').limit(ranking_number).count('item_id')
    set_params

    render 'ranking'
  end

  def want
    @title = "Wantランキング"
    @items = Want.group(:item_id).order('count_item_id desc').limit(ranking_number).count('item_id')
    set_params

    render 'ranking'
  end

  private
    def ranking_number
      ranking_number = 10
    end

    def set_params
      item_ids = @items.keys
      items_count = @items.values
      ranking = [*1..ranking_number]
      item_datas = Item.find(item_ids).sort_by{|o| item_ids.index(o.id)}
      @ranking_ary = ranking.zip(items_count, item_datas)
      @ranking =  0
      @count = 1
      @item_data = 2
    end
end
