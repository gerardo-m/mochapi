# query_parameters - contains parameters that were sent as part of the query string.
# request_parameters - contains parameters sent as part of the post body.
# path_parameters - contains parameters parsed by the router as being part of the
#   path leading to this particular controller and action.
class MochapiRequest
  attr_accessor :headers, :query_parameters, :request_parameters, :path_parameters
end
