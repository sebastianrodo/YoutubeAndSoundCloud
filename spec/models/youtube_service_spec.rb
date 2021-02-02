require 'rails_helper'
require 'pry'

RSpec.describe YoutubeService do
  describe 'class methods' do
    let!(:client_stub) do Google::APIClient.new(key: ENV['DEVELOPER_KEY'],
                                                authorization: nil,
                                                application_name: $PROGRAM_NAME,
                                                application_version: '1.0.0')
    end

    let(:user_agent) { client_stub.user_agent = client_stub.user_agent.gsub("\n", '') }
    let(:youtube) { client_stub.discovered_api(ENV['YOUTUBE_API_SERVICE_NAME'], ENV['YOUTUBE_API_VERSION']) }

    describe '#initialize' do
      context "initialize google APIClient" do
        subject { YoutubeService.new }

        before do
          expect(Google::APIClient).to receive(:new).with(key: ENV['DEVELOPER_KEY'],
                                                          authorization: nil,
                                                          application_name: $PROGRAM_NAME,
                                                          application_version: '1.0.0').and_return(client_stub)

          user_agent
        end
          it {subject }
          it { is_expected.to be_a(described_class) }
      end
    end

    describe '#init_search' do
      context "initialize google APIClient" do
        let(:object) { YoutubeService.new }
        subject { object.init_search(query) }

        let(:query) { "Videos de Risa" }
        let(:maxresults) { 1 }

        before do
          user_agent
          allow(object).to receive(:init_search).with(query)
        end

        it { subject }
      end
    end
  end
end
