class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find_by(params[:slug_name])
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find_by(params[:slug_name])
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail[:slug_name])
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    cocktail = @dose.cocktail
    @dose.delete
    redirect_to cocktail_path(cocktail[:slug_name])
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
