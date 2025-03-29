module Constants
  VERSION="v0.2.0"
  SUPPORTED_METHODS=[ "GET", "POST", "PATCH", "PUT", "DELETE" ]

  EXPRESSION_FORM_TYPES = [ "type", "presence" ]
  OPERAND_TYPES = [ "header", "param" ]
  EXPRESSION_OPERANDS={ "IS_A_NUMBER"=>"type", "IS_NOT_A_NUMBER"=>"type",
    "IS_PRESENT"=>"presence", "IS_NOT_PRESENT"=> "presence"
  }
end
