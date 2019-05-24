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
    if @cocktail.save
      redirect_to cocktail_path(@cocktail.id)
    else
      render :new
    end
  end

  private

  def all_cocktails
    @cocktails = Cocktail.all
  end

  def set_cocktail
    @cocktail = Cocktail.find_by(name: params[:name].split('-').join(' ').titleize)
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end
end
