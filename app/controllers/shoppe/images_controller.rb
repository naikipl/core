module Shoppe
  class ImagesController < Shoppe::ApplicationController

    def destroy
      @image = Shoppe::Image.find(params[:id])
      @image.destroy
      respond_to do |wants|
        wants.html { redirect_to request.referer, :notice => t('shoppe.attachments.remove_notice')}
        wants.json { render :status => 'complete' }
      end
    end

  end
end
