require 'soundcloud'

class SoundcloudService
  CLIENT_ID = 'b58fafed3cba2066d07ae1cd704f7c39'

  def initialize
    @client = Soundcloud.new(client_id: CLIENT_ID)
  end

  def init_search(title)
    @client.get('/tracks', q: title, limit: 5)
  end
end
