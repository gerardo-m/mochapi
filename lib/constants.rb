module Constants
  VERSION="v0.2.0"
  SUPPORTED_METHODS=[ "GET", "POST", "PATCH", "PUT" ]
  EXPRESSION_OPERANDS={ "IS_A"=>"type", "IS_NOT_A"=>"type",
    "IS_PRESENT"=>"presence", "IS_NOT_PRESENT"=> "presence"
  }
end
