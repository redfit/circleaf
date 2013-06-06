module Levelable
  extend ActiveSupport::Concern

  def level_label
   self.class.label(level)
  end

  module ClassMethods
    def level_collection
      self::LEVELS.map{|v| [label(v), v]}
    end

    def label(s)
      I18n::t("#{self.name.downcase}.level.labels.#{s}")
    end
  end
end
