class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def create 
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find_by(id: params[:id])
        lease.destroy
        head :no_content
    end

    private 

    # use in CREATE, UPDATE
    def lease_params 
        params.permit(:rent)
    end

    def render_not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end
end
