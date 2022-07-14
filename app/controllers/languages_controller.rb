class LanguagesController < ApplicationController 

    def show_many

        page = params[:page]
        per_page = 5

        if page
            # Page was specified




            #returnval = {data:Language.offset(per_page * page).limit(per_page, meta:)}



        else
            # Page was unspecified

        end

    end

end