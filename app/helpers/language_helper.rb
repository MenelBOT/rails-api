module LanguageHelper

    def normalize_return(query_return)

        if query_return.respond_to?(:to_a) && (query_return.kind_of?(Array) || query_return.to_a.kind_of?(Array))

            return query_return

        elsif is_falsy?(query_return)

            return []

        else

            return [query_return]

        end

    end

    def is_falsy?(test)

        return [{}, [], nil, false, 0].include?(test)

    end

end