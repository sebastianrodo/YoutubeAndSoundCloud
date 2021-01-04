require 'google/api_client'

class YoutubeService
  DEVELOPER_KEY = 'AIzaSyDWzjeSx0l1GtDS3Kunc9zaUyca6Lx0o10'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'
  MAX_RESULTS = 5
  attr_reader :client, :youtube

  def initialize
    @client = Google::APIClient.new(
      key: DEVELOPER_KEY,
      authorization: nil,
      application_name: $PROGRAM_NAME,
      application_version: '1.0.0'
    )
    @client.user_agent = @client.user_agent.gsub("\n", '')
    @youtube = @client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
  end

  def init_search(query)
    search_response = client.execute!(
      api_method: youtube.search.list,
      parameters: {
        part: 'snippet',
        q: query,
        maxResults: MAX_RESULTS
      }
    )

    result(search_response)
  end

  def result(search_response)
    search_response.data.items.each_with_object([]) do |search_result, videos|
      if search_result.id.kind == 'youtube#video'
        videos << { title: search_result.snippet.title, video_id: search_result.id.videoId }
      end
    end
  end
end
