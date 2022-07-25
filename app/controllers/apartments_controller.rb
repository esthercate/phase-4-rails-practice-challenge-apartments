class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def index 
        render json: Student.all
    end

    def show 
        apartment = Apartment.find_by(id: params[:id])
        render json: apartment
    end

    def create 
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update 
        apartment = Apartment.find_by(id: params[:id])
        apartment.update(apartment_params)
        render json: apartment
    end

    def destroy
        apartment = Apartment.find_by(id: params[:id])
        apartment.destroy
        head :no_content
    end

    private 

    # use in CREATE, UPDATE
    def apartment_params 
        params.permit(:number)
    end

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end
end
