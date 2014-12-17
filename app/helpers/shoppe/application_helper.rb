module Shoppe
  module ApplicationHelper

    def navigation_manager_link(item)
      link_to item.description, item.url(self), item.link_options.merge(:class => item.active?(self) ? 'active' : 'inactive')
    end

    def status_tag(status)
      content_tag :span, status, :class => "status-tag #{status}"
    end

    def settings_label(field)
      "<label for='settings_#{field}'>#{t("settings.labels.#{field}")}</label>".html_safe
    end

    def remove_datasheet_link(product)
      label = t('shoppe.helpers.attachment_preview.delete', default: 'Delete this file?')
      confirm_text = t('shoppe.helpers.attachment_preview.delete_confirm', default: "Are you sure you wish to remove this attachment?")
      link_to(label, remove_datasheet_product_path(product), method: :put, data: {confirm: confirm_text })
    end

    def delete_image_link(image)
      label = t('shoppe.helpers.attachment_preview.delete', default: 'Delete this file?')
      confirm_text = t('shoppe.helpers.attachment_preview.delete_confirm', default: "Are you sure you wish to remove this attachment?")
      link_to(label, image_path(image), method: :delete, data: { confirm: confirm_text })
    end

    def settings_field(field, options = {})
      default = I18n.t("shoppe.settings.defaults")[field.to_sym]
      value = (params[:settings] && params[:settings][field]) || Shoppe.settings[field.to_s]
      type = I18n.t("shoppe.settings.types")[field.to_sym] || 'string'
      case type
      when 'boolean'
        String.new.tap do |s|
          value = default if value.blank?
          s << "<div class='radios'>"
          s << radio_button_tag("settings[#{field}]", 'true', value == true, :id => "settings_#{field}_true")
          s << label_tag("settings_#{field}_true", t("shoppe.settings.options.#{field}.affirmative", :default => 'Yes'))
          s << radio_button_tag("settings[#{field}]", 'false', value == false, :id => "settings_#{field}_false")
          s << label_tag("settings_#{field}_false", t("shoppe.settings.options.#{field}.negative", :default => 'No'))
          s << "</div>"
        end.html_safe
      else
        text_field_tag "settings[#{field}]", value, options.merge(:placeholder => default, :class => 'text')
      end
    end

    def t text , opts = {}
      opts[:scope] = "shoppe" unless opts[:scope]
      I18n.t( text , opts)
    end

  end
end
