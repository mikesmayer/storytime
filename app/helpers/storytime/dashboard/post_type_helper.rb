module Storytime
  module Dashboard
    module PostTypeHelper

      def link_to_add_custom_field(name, f, type)
        new_object = f.object.custom_fields.klass.new(type: type.to_s)
        id = new_object.object_id
        fields = f.fields_for(:custom_fields, new_object, child_index: id) do |builder|
          partial_name = "custom_#{type.to_s.split("::").last.gsub("Field", "").underscore}_field_fields" 
          render(partial_name, f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
      end

    end
  end
end