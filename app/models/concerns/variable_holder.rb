### Represents a model that can have instances of MVariable associated with it.
###
### Implementing this also allows to assign parents so this model can "inherit"
### MVariable instances from its associations. Use the `variable_holder_parent`
### macro to assign it. The argument must be a String or a Symbol, and also
### be the name of an association present in the model.
###
### The methods provided by this Concern are:
### - variables - will return this model assigned variables and also the
### inherited variables from its parent(s), with no repetition. That means that
### if the parent has a variable `a` and this model also has a variable named
### `a`, the latter will "hide" the one from the parent.
### - inherited_variables - will return the variables inherited from the parent
### that are not overwritten by this model own variables.
### - all_inherited_variables - will return all the variables inherited from the
### parent including the variables overwritten byt this model.
### - own_variables - will return only the variables set on this model
module VariableHolder
  extend ActiveSupport::Concern

  included do
    has_many :m_variables, as: :variable_holder, dependent: :destroy

    def variables
      my_variables = inherited_variables
      my_variables.concat(self.m_variables)
      my_variables
    end

    def all_inherited_variables
      all_variables = []
      self.class.m_variable_holder_parents.each do |v_holder|
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

    def own_variables
      self.m_variables
    end

    def get_or_create_variable(name)
      self.m_variables.find_or_create_by(name: name)
    end
  end

  class_methods do
    def variable_holder_parent(parent_symbol)
      parent_symbol = parent_symbol.to_sym if parent_symbol.is_a? String
      throw ArgumentError("The parent must be a Symbol or a String") unless parent_symbol.is_a? Symbol
      parent_assoc = reflect_on_all_associations.select { |assoc| assoc.name == parent_symbol }.count
      throw ArgumentError("The parent must be a valid association") unless parent_assoc > 0
      m_variable_holder_parents << parent_symbol
    end

    def m_variable_holder_parents
      @m_variable_holder_parents ||= []
    end

    def valid_classes
      [ "Project", "Endpoint" ]
    end
  end

  protected
end
