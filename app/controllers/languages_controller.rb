class LanguagesController < ApplicationController 
    include LanguageHelper


    def show_many

        page = params[:page]

        page = ensure_unsigned_integer(page)

        per_page = 5

        render :json => pretty_print_for_render(generate_return({page: page.to_i() - 1, per_page: per_page})), :status => 200

    end

    def show

        id = params[:languageID]

        id = ensure_unsigned_integer(id)

        render :json => pretty_print_for_render(generate_return({:languageID => id})), :status => 200

    end

    private

    def ensure_unsigned_integer(to_normalize)

        begin

            to_normalize = to_normalize.to_i
            to_normalize = 1 if to_normalize <= 0

        rescue

            to_normalize = 1

        end

        return to_normalize

    end

    def pretty_print_for_render(val)

        return JSON.pretty_generate(ActiveSupport::JSON.decode(ActiveSupport::JSON.encode val))

    end

    def generate_return(args)

        if args[:page]

            return { :data => normalize_return(Language.offset(args[:per_page] * args[:page]).limit(args[:per_page])), :meta => { page: args[:page] } }

        elsif args[:languageID]

            return { :data => normalize_return(Language.find(args[:languageID])), :meta => { :id => args[:languageID] } }

        else

            return nil

        end

    end

end