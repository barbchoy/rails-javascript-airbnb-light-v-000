class HousesController < ApplicationController
  def index
    @houses = House.all
    if params[:price_per_night]=="High to Low"
      @houses = @houses.sort_by_price_per_night_desc
    elsif params[:price_per_night]=="Low to High"
      @houses = @houses.sort_by_price_per_night_asc
    end

    if params[:pets_allowed] == "Yes"
      @houses = @houses.pets_ok
    elsif params[:pets_allowed] == "No"

      @houses = @houses.pets_not_ok
    end

    if params[:max_guests]!="" && params[:max_guests]
      @houses = @houses.mininum_guest(params[:max_guests])
    end

    if params[:city] && params[:city]!=""
      @houses = @houses.in_location(params[:city])
    end

    respond_to do |f|
         f.html {render :index}
         f.json {render json: @houses}
     end

  end

  def create
    @house = House.create(house_params)
    @house.owner = current_user
    if @house.save
      redirect_to house_path(@house)
    else
      render 'new'
    end
  end

  def new
    @house = House.new
  end

  def edit
    @house = House.find(params[:id])
  end

  def show
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update_attributes(house_params)
      redirect_to house_path(@house)
    else
      render 'edit'
    end

  end


  def destroy
    @house = House.find(params[:id])
    @house.destroy

    redirect_to houses_path
  end

  private

  def house_params
    params.require(:house).permit(:name, :price_per_night, :city, :max_guests, :pets_allowed, reviews_attributes: [:title, :cleanliness_rating, :location_rating, :value_rating, :comments, :house_id, :user_id] )
  end
end
