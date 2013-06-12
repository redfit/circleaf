module Scopable
  extend ActiveSupport::Concern

  def scope_label
   self.class.label(scope)
  end

  module ClassMethods
    def scope_collection
      self::SCOPES.map{|v| [label(v), v]}
    end

    def label(s)
      I18n::t("#{self.name.downcase}.scope.labels.#{s}")
    end
  end
end
