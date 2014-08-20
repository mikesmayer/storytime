module Storytime
  class CustomField < ActiveRecord::Base
    belongs_to :post_type
    has_many :custom_field_responses

    TYPES = %w{TextField SelectField}

    #validates :type, inclusion: { in: type_classes }

    def self.type_classes
      TYPES.map{|type| "Storytime::CustomFields::#{type}" }
    end

    def partial_name
      type.split("::").last.underscore
    end
  end
end
