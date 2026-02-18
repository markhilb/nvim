; extends

(macro_invocation
    (scoped_identifier
        path: (identifier) @_path (#eq? @_path "sqlx")
        name: (identifier) @_name (#match? @_name "query")
    )
    (token_tree
        (raw_string_literal
            (string_content) @injection.content
        )
    )
    (#set! injection.language "sql")
    (#set! "priority" 110)
)

(macro_invocation
    macro: (identifier) @_macro (#any-of? @_macro "fetch_optional" "fetch_all" "insert" "execute")
    (token_tree
        (raw_string_literal
            (string_content) @injection.content
        )
    )
    (#set! injection.language "sql")
)

(call_expression
    (field_expression
        field: (field_identifier) @_field (#any-of? @_field "query" "execute")
    )
    (arguments
        (raw_string_literal
            (string_content) @injection.content
        )
    )
    (#set! injection.language "sql")
)
