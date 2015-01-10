module Shoppe
  class ProductsController < Shoppe::ApplicationController

    before_filter { @active_nav = :products }
    before_filter { params[:id] && @product = Shoppe::Product.root.find(params[:id]) }

    def index
      @products = Shoppe::Product.root.includes(:stock_level_adjustments, :product_category, :variants).order(:name).group_by(&:product_category).sort_by { |cat,pro| cat.name }
    end

    def new
      @product = Shoppe::Product.new
    end

    def create
      @product = Shoppe::Product.new(safe_params)
      if @product.save
        if params[:product][:images]
          params[:product][:images].each do |image|
            @product.images.create(source: image)
          end
        end

        redirect_to :products, :flash => {:notice => confirm_added(:product) }
      else
        render :action => "new"
      end
    end

    def edit
    end

    def update
      if @product.update(safe_params)
        if params[:product][:images]
          params[:product][:images].each do |image|
            @product.images.create(source: image)
          end
        end
        redirect_to [:edit, @product], :flash => {:notice => confirm_updated(:product) }
      else
        render :action => "edit"
      end
    end

    def remove_datasheet
      @product.data_sheet = nil
      if @product.save
        redirect_to [:edit, @product], :flash => {:notice => confirm_updated(:product) }
      else
        render :action => "edit"
      end
    end

    def destroy
      @product.destroy
      redirect_to :products, :flash => {:notice => confirm_removed(:product)}
    end

    private

    def safe_params
      params[:product].permit(:product_category_id, :name, :sku, :permalink, :description, :short_description, :weight, :price, :cost_price, :tax_rate_id, :stock_control, :data_sheet, :active, :featured, :in_the_box, :product_attributes_array => [:key, :value, :searchable, :public])
    end

  end
end
