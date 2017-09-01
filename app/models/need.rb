class Need < ApplicationRecord
  geocoded_by :address

  def clean_needs
    return [] if tell_us_about_the_supply_needs.blank?
    tell_us_about_the_supply_needs
      .gsub("\n","")
      .gsub("*", ",")
      .split(",")
      .reject{|n| n =~ /^open/i }
      .map(&:strip)
      .select(&:present?)
  end
end
