require 'rails_helper'
require 'pry'

RSpec.describe SoundcloudService do
  describe 'class methods' do
    let(:client_stub) { Soundcloud.new(client_id: ENV['CLIEND_ID']) }

    describe '#initialize' do
      subject { described_class.new }

      context 'with attrs' do
        before do
          expect(Soundcloud).to receive(:new).with(client_id: ENV['CLIEND_ID']).and_return(client_stub)
        end

        it { subject }
        it { is_expected.to be_a(described_class) }
      end
    end

    describe '#init_search' do
      subject {  client_object.init_search(title) }

      let!(:client_object) { SoundcloudService.new }
      let(:title) { "Toda" }
      let(:limit) { 1 }

      context 'with attrs' do
        before do
          expect(client_object).to receive(:init_search).with(title)
        end

        it { subject }
      end
    end
  end
end
