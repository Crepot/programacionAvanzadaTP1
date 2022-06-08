class CompaniesController < ApplicationController
    #Get one company
    def show
        render status: 200, json:{company: @company}
    end

    def index
        @Company = Company.all
        render status: 200, json:{company: @company}
    end
end
