class LanguagesController < ApplicationController 
    include LanguageHelper


    def show_many

        page = params[:page]
        per_page = 5

        returnval = generate_return(page.to_i - 1, per_page)

        render :json => JSON.pretty_generate(ActiveSupport::JSON.decode(ActiveSupport::JSON.encode returnval)), :status => 200

    end

    private

    def generate_return(page = 1, per_page)

        return { :data => normalize_return(Language.offset(per_page * page).limit(per_page)), :meta => { page: page } }

    end

end