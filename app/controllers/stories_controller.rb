class StoriesController < ApplicationController

  def index
    if IndividualType.find_by_title('adesias_videos')      
      @adesias_videos = IndividualType.find_by_title('adesias_videos').get_members
    end      
  end

  def show
    @adesias_video = Individual.find(params[:id])

    @next_video = get_next_video
    @previous_video = get_previous_video

    @next_videos = get_next_videos(3)
  end

  def get_next_videos(video_number)
    @adesias_videos = IndividualType.find_by_title('adesias_videos').get_members
    @next_videos = @adesias_videos.select{|n| n.id > params[:id].to_i}
     
    if !@next_videos.nil? && @next_videos.count >= video_number
      @next_videos.first(video_number)
    else
      @adesias_videos.first(video_number - @next_videos.count).each do |video|
        @next_videos << video
      end
      @next_videos.sort
    end

  end

  def get_next_video
    @adesias_videos = IndividualType.find_by_title('adesias_videos').get_members

    @next_video = @adesias_videos.first(:conditions => ['individuals.id > ?', params[:id]], :order => 'id ASC')

    if !@next_video.nil?
      @next_video
    else
      @adesias_videos.first
    end

  end 

  def get_previous_video
    @adesias_videos = IndividualType.find_by_title('adesias_videos').get_members

    @previous_video = @adesias_videos.last(:conditions => ['individuals.id < ?', params[:id]])

    if !@previous_video.nil?
      @previous_video
    else
      @adesias_videos.last
    end
  end

end
