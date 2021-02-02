require 'soundcloud'

class SoundcloudService
  LIMIT = 3

  def initialize
    @client = Soundcloud.new(client_id: ENV['CLIEND_ID'])
  end

  def init_search(title)
    @client.get('/tracks', q: title, limit: LIMIT)
  end
end
