class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def index 
        render json: Tenant.all
    end

    def show 
        tenant = Tenant.find_by(id: params[:id])
        render json: tenant
    end

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update 
        tenant = Tenant.find_by(id: params[:id])
        tenant.update(tenant_params)
        render json: tenant
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        tenant.destroy
        head :no_content
    end

    private 

    # use in CREATE, UPDATE
    def tenant_params 
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end
end
