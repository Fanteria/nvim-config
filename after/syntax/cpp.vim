syntax match cppCustomOperator "+=\|-=\|="
syntax match cppCustomOperator "+\|-\|++\|--"
syntax match cppCustomOperator "==\|!=\|>=\|<=\|<\|>"
syntax match cppCustomOperator ">>\|<<\|!\|&&\|||"
syntax match cppCustomOperator "!\|&&\|||"
syntax match cppCustomOperator "&\|*"
syntax keyword cppThis this

highlight def link cppCustomOperator Operator
highlight def link cppThis cppModifier

