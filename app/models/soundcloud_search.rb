require 'soundcloud'

class SoundcloudSearch
  def initialize
    client_object
  end

  def client_object
    @client = Soundcloud.new(:client_id => 'b58fafed3cba2066d07ae1cd704f7c39')

    end

  def search(title)
    @tracks = @client.get('/tracks', :q => title, :limit => 30)
  end
end