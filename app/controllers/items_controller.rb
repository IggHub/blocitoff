class ItemsController < ApplicationController
  def new
    #is this necessary?
  end

  def create


    @user = User.find(params[:user_id])
    @item = current_user.items.create(item_params)

    #@item = Item.new(item_params)
    #@item.user = current_user #need to define current_user(?)
#do I use Item.new, or @item = current_user.items.create(item_params) - or something like that?
    #need to check code below:
    if @item.save
      flash[:notice] = "Item was created!"
      redirect_to @user
    else
      flash.now[:alert] = "Alert!!! Unable to create item"
      redirect_to @user
    end

  end

  def update
  end

  def destroy
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])
    @item.destroy

    if @item.destroy
      flash[:notice] = "Item was checked! Good job!"
      redirect_to @user
    else
      flash.now[:alert] = "Alert!!! Unable to delete item!"
      redirect_to @user
    end
  end


  def show
  end

  private
  def item_params
    params.require(:item).permit(:name)
  end


  respond_to do |format|
   format.html
   format.js
  end

end
