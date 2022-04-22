class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
    @bulk_discount.update(bulk_discount_params)
    @bulk_discount.save
    redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    # redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount.id}"
    # @merchant.bulk_discounts.find
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.new(percent: params[:percent], threshold: params[:threshold])

    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash[:alert] = "Error : #{error_message(bulk_discount.errors)}"
    end
    # redirect_to "/merchants/#{@merchant.id}/bulk_discounts/"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
    # redirect_to "/merchant/#{merchant.id}/bulk_discounts"
  end

  private
          def bulk_discount_params
            params.require(:bulk_discount).permit(:percent, :threshold)
          end
end
