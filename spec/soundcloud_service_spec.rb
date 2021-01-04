require_relative '../app/services/soundcloud_service'
require 'pry'

RSpec.describe SoundcloudService do
  subject { SoundcloudService.new }
  let(:client_id) { "b58fafed3cba2066d07ae1cd704f7c39" }

  context "with attrs" do
    let(:stub_client) { Soundcloud.new(client_id: client_id) }
    let(:title) { "Toda" }
    let(:limit) { 1 }

    let(:search_result) { stub_client.get('/tracks', q: title, limit: limit)}

    let!(:soundcloud_resp) do
      instance_double('SoundCloud::Object', kind: "track",
        id: 452021064,
        created_at: "2018/06/01 00:39:17 +0000",
        user_id: 173436177,
        duration: 367811,
        comment_count: 1534,
        original_content_size: 14987647,
        last_modified: "2020/11/10 23:33:42 +0000",
        sharing: "public",
        genre: "Dancehall",
        title: "Alex Rose - Toda (Remix) - Ft. Cazzu, Lenny Tavarez, Rauw Alejandro & Lyanno",
        description: "")
    end

    before do
      expect(Soundcloud).to receive(:new).with(client_id: client_id).and_return(stub_client)
      allow(stub_client).to receive(:get).with('/tracks', q: title, limit: limit).and_return(soundcloud_resp)
    end

    it { subject }
    it { is_expected.to be_a(described_class) }
  end
end
