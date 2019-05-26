class CocktailsController < ApplicationController
  before_action :all_cocktails
  before_action :set_cocktail, only: [:show]

  def index
    @cocktail = Cocktail.new
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail[:slug_name] = @cocktail.name.downcase.parameterize
    if @cocktail.save
      redirect_to cocktail_path(@cocktail[:slug_name])
    else
      render :new
    end
  end

  private

  def all_cocktails
    @cocktails = Cocktail.all
  end

  def set_cocktail
    @cocktail = Cocktail.find_by(slug_name: params[:slug_name])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end
end
