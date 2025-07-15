module VariableHolder
  extend ActiveSupport::Concern

  included do
    @@m_variable_holder_parents = []
    has_many :m_variables

    def variables
      my_variables = inherited_variables
      my_variables.concat(self.m_variables)
      my_variables
    end

    def all_inherited_variables
      all_variables = []
      @@m_variable_holder_parents.each do |v_holder|
        actual_parent = self.send(v_holder)
        all_variables.concat(actual_parent.m_variables)
      end
      all_variables
    end

    def inherited_variables
      all_variables = all_inherited_variables
      self.m_variables.each do |m_variable|
        all_variables.delete_if do |variable|
          m_variable.name.strip == variable.name.strip
        end
      end
      all_variables
    end
  end

  class_methods do
    def variable_holder_parent(parent_symbol)
      parent_symbol = parent_symbol.to_sym if parent_symbol.is_a? String
      throw ArgumentError("The parent must be a Symbol or a String") unless parent_symbol.is_a? Symbol
      @@m_variable_holder_parents << parent
    end
  end
end
