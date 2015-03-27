module Shoppe
  class SettingsController < ApplicationController

    before_filter { @active_nav = :settings }

    def update
      if Shoppe.settings.demo_mode?
        raise Shoppe::Error, t('shoppe.settings.demo_mode_error')
      end

      styles = {}
      params[:settings][:image_styles].each do |style|
        styles[style['name']] = style['dimensions'] if style['name'].present?
      end
      params[:settings][:image_styles] = styles

      Shoppe::Setting.update_from_hash(params[:settings].permit!)
      redirect_to :settings, :notice => t('shoppe.settings.update_notice')
    end

  end
end
