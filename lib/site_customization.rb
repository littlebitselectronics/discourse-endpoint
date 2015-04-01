class SiteCustomization < ActiveRecord::Base
  def self.lookup_field(key, target, field)
    return if key.blank?

    cache_key = key + target.to_s + field.to_s;

    lookup = @cache[cache_key]
    return lookup.html_safe if lookup

    styles = if key == ENABLED_KEY
      order(:name).where(enabled:true).to_a
    else
      [find_by(key: key)].compact
    end

    val = if styles.present?
      styles.map do |style|
        lookup = target == :mobile ? "mobile_#{field}" : field
        style.send(lookup)
      end.compact.join("\n")
    end
    Rails.logger.info("this is a test" + "*"*50)
    (@cache[cache_key] = val || "").html_safe
  end
end