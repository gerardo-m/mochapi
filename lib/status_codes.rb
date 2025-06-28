module StatusCodes
  def self.all
    [
      # 1xx Informational
      KeyValue.new(100, "Continue"),
      KeyValue.new(101, "Switching Protocols"),
      KeyValue.new(102, "Processing"),
      KeyValue.new(103, "Early Hints"),

      # 2xx Success
      KeyValue.new(200, "OK"),
      KeyValue.new(201, "Created"),
      KeyValue.new(202, "Accepted"),
      KeyValue.new(203, "Non-Authoritative Information"),
      KeyValue.new(204, "No Content"),
      KeyValue.new(205, "Reset Content"),
      KeyValue.new(206, "Partial Content"),
      KeyValue.new(207, "Multi-Status"),
      KeyValue.new(208, "Already Reported"),
      KeyValue.new(226, "IM Used"),

      # 3xx Redirection
      KeyValue.new(300, "Multiple Choices"),
      KeyValue.new(301, "Moved Permanently"),
      KeyValue.new(302, "Found"),
      KeyValue.new(303, "See Other"),
      KeyValue.new(304, "Not Modified"),
      KeyValue.new(305, "Use Proxy"),
      KeyValue.new(307, "Temporary Redirect"),
      KeyValue.new(308, "Permanent Redirect"),

      # 4xx Client Errors
      KeyValue.new(400, "Bad Request"),
      KeyValue.new(401, "Unauthorized"),
      KeyValue.new(402, "Payment Required"),
      KeyValue.new(403, "Forbidden"),
      KeyValue.new(404, "Not Found"),
      KeyValue.new(405, "Method Not Allowed"),
      KeyValue.new(406, "Not Acceptable"),
      KeyValue.new(407, "Proxy Authentication Required"),
      KeyValue.new(408, "Request Timeout"),
      KeyValue.new(409, "Conflict"),
      KeyValue.new(410, "Gone"),
      KeyValue.new(411, "Length Required"),
      KeyValue.new(412, "Precondition Failed"),
      KeyValue.new(413, "Payload Too Large"),
      KeyValue.new(414, "URI Too Long"),
      KeyValue.new(415, "Unsupported Media Type"),
      KeyValue.new(416, "Range Not Satisfiable"),
      KeyValue.new(417, "Expectation Failed"),
      KeyValue.new(418, "I'm a teapot"),
      KeyValue.new(421, "Misdirected Request"),
      KeyValue.new(422, "Unprocessable Entity"),
      KeyValue.new(423, "Locked"),
      KeyValue.new(424, "Failed Dependency"),
      KeyValue.new(425, "Too Early"),
      KeyValue.new(426, "Upgrade Required"),
      KeyValue.new(428, "Precondition Required"),
      KeyValue.new(429, "Too Many Requests"),
      KeyValue.new(431, "Request Header Fields Too Large"),
      KeyValue.new(451, "Unavailable For Legal Reasons"),

      # 5xx Server Errors
      KeyValue.new(500, "Internal Server Error"),
      KeyValue.new(501, "Not Implemented"),
      KeyValue.new(502, "Bad Gateway"),
      KeyValue.new(503, "Service Unavailable"),
      KeyValue.new(504, "Gateway Timeout"),
      KeyValue.new(505, "HTTP Version Not Supported"),
      KeyValue.new(506, "Variant Also Negotiates"),
      KeyValue.new(507, "Insufficient Storage"),
      KeyValue.new(508, "Loop Detected"),
      KeyValue.new(510, "Not Extended"),
      KeyValue.new(511, "Network Authentication Required")
    ]
  end
end
