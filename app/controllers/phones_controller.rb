class PhonesController < ApplicationController
	swagger_controller :phones, "Add a new phone"

	swagger_api :create do 
		summary "Connect a phone to the system"
		param :form, :number, :string, :required, "The phone number"
	end

	def create
		@p = Phone.where(phone_params).first_or_create
		respond_to do |format|
      		format.html { redirect_to phone_path(@p) and return }
      		format.json { render :json => @p }
    	end
	end

	private
	def phone_params
		params.require(:phone).permit(:number)
	end
end
