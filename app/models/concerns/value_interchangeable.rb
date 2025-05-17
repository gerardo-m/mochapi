module ValueInterchangeable
  extend ActiveSupport::Concern

  included do
    @@remembered_values_map = {}

    has_many :remembered_values, as: :value_interchangeable
    before_update :remember_values

    private

    def remember_values
      @@remembered_values_map.each do |control_attr, value_attrs|
        m= "#{control_attr}_changed?"
        next unless send(m)
        old_control_attribute_value = send("#{control_attr}_was")
        new_control_attribute_value = send("#{control_attr}")
        rv = remembered_values.with_control_attribute(control_attr)
        value_attrs.each do |value_attr|
          value_attr_was = "#{value_attr}_was"
          old_rv = rv.find_or_create_by(control_attribute_value: old_control_attribute_value, value_attribute: value_attr)
          old_rv.value_attribute_value = send(value_attr_was)
          old_rv.value_attribute_type = old_rv.value_attribute_value.class
          old_rv.save!
          new_rv = rv.where(control_attribute_value: new_control_attribute_value, value_attribute: value_attr).first
          unless new_rv.nil?
            send("#{value_attr}=", new_rv.value_attribute_value)
          end
        end
      end
      # control_attributes = remembered_values.select(:control_attribute).distinct
      # control_attributes.each do |control_attribute|
      #   m = "#{control_attribute}_changed?"
      #   if send(m)

      #   end
      # end
    end
  end

  class_methods do
    def remember_value(control_attribute, value_attribute)
      control_attribute = control_attribute.to_sym if control_attribute.is_a? String
      throw ArgumentError("control_attribute is not a String nor a Symbol") unless control_attribute.is_a? Symbol
      if @@remembered_values_map[control_attribute].nil?
        @@remembered_values_map[control_attribute] = []
      end
      unless @@remembered_values_map[control_attribute].include?(value_attribute)
        @@remembered_values_map[control_attribute] << value_attribute
      end
    end
  end
end
