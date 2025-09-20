module Expressions
  class Operation
    # Detemines the values that the operands can be or return
    OPERAND_RETURN_TYPES = [ :boolean, :string, :number ]
    # Determines the form that the operands can be rendered in
    OPERAND_FORM_TYPES = [ :value, :name, :expression ]

    def initialize(negation: false)
      @is_negation = negation
    end

    # Must be implemented by the subclass
    def is_met?(expression, mochapi_request)
      raise NotImplementedError, "Subclass must implement this method"
    end

    # Returns true if the operation object is a negation
    def is_negation?
      @is_negation
    end

    # Returns the number of operands that the operation can have
    def operands_count
      self.class.get_operands_count
    end

    # Returns the types that the operands can be or return
    def operand_return_types
      self.class.get_operand_return_types
    end

    # Returns the forms that the operands can be rendered in
    def operand_form_types
      self.class.get_operand_form_types
    end

    # Returns the name of the operation as provided by the subclass
    def name
      if is_negation?
        self.class.get_negation_name
      else
        self.class.get_main_name
      end
    end

    class << self
      # Sets the name of the operation as provided by the subclass
      def main_name(name)
        @main_name ||= name
      end

      # Sets the name of the negation of the operation as provided by the subclass
      def negation_name(name)
        @negation_name ||= name
      end

      # Sets the number of operands that the operation can have
      def operands_count(count)
        @operands_count ||= count
      end

      # Sets the types that the operands can be or return
      def operand_return_types(*types)
        @operand_return_types ||= []
        i_types = types.uniq
        i_types.each do |type|
          if !OPERAND_RETURN_TYPES.include?(type)
            raise ArgumentError, "Invalid operand return type: #{type}. Valid types are: #{OPERAND_RETURN_TYPES.join(", ")}"
          end
          @operand_return_types << type
        end
      end

      # Sets the forms that the operands can be rendered in
      def operand_form_types(*types)
        @operand_form_types ||= []
        i_types = types.uniq
        i_types.each do |type|
          if !OPERAND_FORM_TYPES.include?(type)
            raise ArgumentError, "Invalid operand form type: #{type}. Valid types are: #{OPERAND_FORM_TYPES.join(", ")}"
          end
          @operand_form_types << type
        end
      end

      def get_operands_count
        @operands_count
      end

      def get_main_name
        @main_name
      end

      def get_negation_name
        @negation_name
      end

      def get_operand_return_types
        @operand_return_types
      end

      def get_operand_form_types
        @operand_form_types
      end

      # Creates a new Operation instance based on the operation name
      def create_new(operation_name)
        operation_classes = Expressions::Operations.constants.select { |c| Expressions::Operations.const_get(c).is_a? Class }
        operation_classes.each do |operation_class|
          operation_class = Expressions::Operations.const_get(operation_class)
          if operation_class.get_main_name == operation_name
            return operation_class.new
          end
          if operation_class.get_negation_name == operation_name
            return operation_class.new(negation: true)
          end
        end
        raise ArgumentError, "Invalid operation name: #{operation_name}"
      end

      def all
        operations = []
        Expressions::Operations.constants.select { |c| Expressions::Operations.const_get(c).is_a? Class }.map do |operation_class|
          operation_class = Expressions::Operations.const_get(operation_class)
          operations << operation_class.get_main_name
          operations << operation_class.get_negation_name unless operation_class.get_negation_name.blank?
        end
        operations
      end

      protected
    end
  end
end
