class CocktailsController < ApplicationController
  before_action :all_cocktails
  before_action :set_cocktail, only: [:show]

  def index
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save
    redirect_to cocktail_path(@cocktail.id)
  end

  private

  def all_cocktails
    @cocktails = Cocktail.all
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
