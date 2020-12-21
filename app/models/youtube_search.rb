require 'google/api_client'

class YoutubeSearch
  DEVELOPER_KEY = 'AIzaSyDWzjeSx0l1GtDS3Kunc9zaUyca6Lx0o10'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'
  attr_reader :client, :youtube

  def initialize
    get_service
  end

  def get_service
    @client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )

    @client.user_agent = @client.user_agent.gsub("\n", "")
    @youtube = @client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
  end

  def search(query)
    @response = {}
    search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => query,
        :maxResults => max_results,
      }
    )
    @videos = []
    search_response.data.items.each do |search_result|
      case search_result.id.kind
        when 'youtube#video'
          @videos << { title: search_result.snippet.title,
                       video_id: search_result.id.videoId
                     }
      end
    end

    @videos
  end

  def max_results
    5
  end
end