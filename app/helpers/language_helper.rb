module LanguageHelper

    def normalize_return(query_return)

        if query_return.kind_of?(Array)

            #
            # TODO: MAKE THIS CHECK IF IT'S AN EMPTY ARRAY YOU KNOW WHAT
            # I'M TALKING AOBUT YOU DUNCE.
            #


            return query_return

        elsif query_return.empty?

            return []

        else

            return [query_return]

        end

    end

end