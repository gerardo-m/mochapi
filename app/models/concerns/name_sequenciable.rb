module NameSequenciable
  extend ActiveSupport::Concern

  class_methods do
    def next_titleized_name(attr, scope = {})
      base_name = name.titleize
      next_name(attr, base_name, " ", scope)
    end

    def next_camelized_name(attr, scope = {})
      base_name = name.camelize
      next_name(attr, base_name, "", scope)
    end

    def next_underscored_name(attr, scope = {})
      base_name = name.underscore
      next_name(attr, base_name, "_", scope)
    end

    private

    def next_name(attr, base_name, separator, scope)
      actual_name = base_name
      i=0
      base_query = all
      scope.each do |key, value|
        base_query = base_query.where(key => value)
      end
      while base_query.where(attr => actual_name).count > 0
        i +=1
        actual_name = "#{base_name}#{separator}#{i}"
      end
      actual_name
    end
  end
end
