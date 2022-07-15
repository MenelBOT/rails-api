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

    def create

        parameters = params.require(:language).permit(:name, :released_year, :githut_rank, :pypl_rank, :tiobe_rank)

        l = Language.where("name = ?", parameters[:name]).pluck(:id).first # Returns nil if record doesn't exist, else returns record ID

        if l.nil?

            begin

                language = Language.create do |lang|

                    lang.name = parameters[:name]
                    lang.released_year = parameters[:released_year]
                    lang.githut_rank = parameters[:githut_rank]
                    lang.pypl_rank = parameters[:pypl_rank]
                    lang.tiobe_rank = parameters[:tiobe_rank]
        
                end

                language.save!

                render :json => pretty_print_for_render(generate_return({:languageID => language.id, :create => {
                    id: language.id, 
                    name: language.name,
                    released_year: language.released_year, 
                    githut_rank: language.githut_rank,
                    pypl_rank: language.pypl_rank,
                    tiobe_rank: language.tiobe_rank
                    }})), status: 200

            rescue

                render head: 400

            end

        else

            render json: { error: "There already exists a language with that name (ID is #{l})\nDid you mean to PUT?" }, status: 400
        

        end

    end

    def update

        parameters = params.require(:language).permit(:name, :released_year, :githut_rank, :pypl_rank, :tiobe_rank)

        l = Language.where("id = ?", params[:languageID]).pluck(:id).first # this will also return nill if record isn't there
                                                                              # otherwise it will return the id but since we already
                                                                              # have it, it's a bit useless. too bad!

        if l.nil?

            render json:{ error: "There exists no language with ID #{l}\nDid you mean to POST?" }, status: 400

        else

            begin

                language = Language.find(l)

                language.update(
                    name: parameters[:name], 
                    released_year: parameters[:released_year], 
                    githut_rank: parameters[:githut_rank], 
                    pypl_rank: parameters[:pypl_rank],
                    tiobe_rank: parameters[:tiobe_rank]
                    )
                
                language.save!

                render :json => pretty_print_for_render(generate_return({:languageID => language.id, :update => {
                    id: language.id, 
                    name: language.name,
                    released_year: language.released_year, 
                    githut_rank: language.githut_rank,
                    pypl_rank: language.pypl_rank,
                    tiobe_rank: language.tiobe_rank
                    }})), status: 200

            rescue

            end

        end



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

        elsif args[:create]

            return { :message => "ok", :created => args[:create] }

        elsif args[:update]

            return { :message => "ok", :updated => args[:update] }

        elsif args[:languageID]

            return { :data => normalize_return(Language.find(args[:languageID])), :meta => { :id => args[:languageID] } }

        else

            return nil

        end

    end

end