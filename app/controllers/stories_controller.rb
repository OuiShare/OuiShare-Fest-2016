class StoriesController < ApplicationController

  def index
    if IndividualType.find_by_title('adesias_videos')      
      @adesias_videos = IndividualType.find_by_title('adesias_videos').get_members
    end      
  end

  def show
    @adesias_video = Individual.find(params[:id])
  end
end
