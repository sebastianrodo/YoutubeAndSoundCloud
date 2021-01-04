require_relative '../app/services/youtube_service'
require 'pry'

RSpec.describe YoutubeService do
  let(:developer_key) { "AIzaSyDWzjeSx0l1GtDS3Kunc9zaUyca6Lx0o10" }
  let(:youtube_api_service_name) { "youtube" }
  let(:youtube_api_version) { "v3" }

  describe '#initalize' do
    context "initialize google APIClient" do
      subject { YoutubeService.new }
      let(:client_stub) do
        Google::APIClient.new(key: developer_key,
          authorization: nil,
          application_name: $PROGRAM_NAME,
          application_version: '1.0.0')
      end

      let(:youtube) { client_stub.discovered_api(youtube_api_service_name, youtube_api_version) }
      let(:query) { "Videos de Risa" }
      let(:maxresults) { 1 }
      let!(:youtube_resp) do
        instance_double('Youtube::Object', kind: "youtube#searchListResponse",
          pageInfo: { totalResults: 1000000,
                      resultsPerPage: 1},
          items:  [{ kind: "youtube#searchResult",
                    etag: "-10zGimZeo73HY1S2q_dUfEg0ws",
                    id: { kind: "youtube#video",
                          videoId: "Lb0y6nS5bQI" },
                    snippet: {  publishedAt: "2020-10-24T16:03:43Z",
                                channelId: "UCQ0_3rtRjjvlQmGZVaG44Ng",
                                title: "Videos De Risa 2020 nuevos <U+1F602> Videos Graciosos
                                        - Personas haciendo cosas graciosas al aire libre #2",
                                description: "Videos De Risa 2020 nuevos Videos Graciosos
                                              - Personas haciendo cosas graciosas al aire libre #2 /
                                              People doing funny things outdoors Des: Momentos ...",
                                thumbnails: { default: {  url: "https://i.ytimg.com/vi/Lb0y6nS5bQI/
                                                                default.jpg",
                                                          width: 120,
                                                          height: 90  },
                                              medium: { url: "https://i.ytimg.com/vi/Lb0y6nS5bQI/
                                                              mqdefault.jpg",
                                                        width: 320,
                                                        height: 180 },
                                              high: { url: "https://i.ytimg.com/vi/Lb0y6nS5bQI/
                                                            hqdefault.jpg",
                                                      width: 480,
                                                      height: 360 }
                                            },
                                channelTitle: "Just Fun",
                                liveBroadcastContent: "none",
                                publishTime: "2020-10-24T16:03:43Z"
                              }
                   }
                  ]
          )
      end

      before do
        expect(Google::APIClient).to receive(:new).with(key: developer_key,
                                                        authorization: nil,
                                                        application_name: $PROGRAM_NAME,
                                                        application_version: '1.0.0').and_return(client_stub)

        client_stub.user_agent = client_stub.user_agent.gsub("\n", '')

        allow(client_stub).to receive(:execute!).with(api_method: youtube.search.list,
                                                parameters: {
                                                  part: 'snippet',
                                                  q: query,
                                                  maxResults: maxresults}).and_return(youtube_resp)
      end
       it {subject }
       it { is_expected.to be_a(described_class) }
    end
  end
end
