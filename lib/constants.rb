module Constants
  VERSION="v0.2.0"
  SUPPORTED_METHODS=[ "GET", "POST", "PATCH", "PUT" ]

  EXPRESSION_FORM_TYPES = [ "type", "presence" ]
  OPERAND_TYPES = [ "header", "param" ]
  OPERAND_VARIABLE_TYPES = [ "number", "text", "null" ]
  # EXPRESSION_FORMS = {
  #   "type" =>     ["number", "text", "null"],
  #   "presence" => ["header", "param"]
  # }
  EXPRESSION_OPERANDS={ "IS_A"=>"type", "IS_NOT_A"=>"type",
    "IS_PRESENT"=>"presence", "IS_NOT_PRESENT"=> "presence"
  }
end
