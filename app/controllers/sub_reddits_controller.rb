class SubRedditsController < ApplicationController
  def index
    render json: SubReddit.order("id DESC").all
  end
  
  def create
    @object = SubReddit.create_object(  params[:sub_reddit] )  
    
    if @object.valid?
      render :json => {
        :success => true 
      }
    else
      render :json => {
        :success => false 
      }
    end
  end
  
  
  def destroy
    @object = SubReddit.find(params[:id])
    @object.delete_object

    if  ( @object.is_deleted)  or  (   not @object.persisted?)
      render :json => { :success => true, :total => SubReddit.active_objects.count }  
    else
      render :json => { 
                  :success => false, 
                  :total => SubReddit.active_objects.count,
                  :message => {
                    :errors => extjs_error_format( @object.errors )  
                  }
               }  
    end
  end
end
