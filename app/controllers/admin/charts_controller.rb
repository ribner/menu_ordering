module Admin
  class ChartsController < ApplicationController
    before_action :authorize_admin

    def index
      @shop = Shop.find(params[:shop_id])
      end_date = 0
      start_date = 6
      @seven_day_sales = n_day_sales(@shop,start_date, end_date)
    end

    private

    def n_day_sales(shop, start_date, end_date)
      week_array = (end_date..start_date).to_a
      seven_day_totals_array = []
      week_array.each do |day|
        daily_total = 0
        total_daily_orders = daily_total(shop,day)
        total_daily_orders.each { |order| daily_total += order.total_price }
        seven_day_totals_array << daily_total
      end
      seven_day_totals_array.reverse
    end

    def daily_total(shop,relative_day)
      shop.orders.all.where(["created_at > ? and created_at < ?", (relative_day + 1).days.ago, relative_day.days.ago])
    end

    def total_price
      self.items.sum(:price)
    end

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

  end
end

