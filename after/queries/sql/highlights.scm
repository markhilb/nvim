; extends

(field
  (identifier) @field
)

(parameter) @sql.parameter

(column) @field

(invocation
  (object_reference) @function
  (#set! "priority" 110)
)
