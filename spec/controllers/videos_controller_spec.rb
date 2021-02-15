require 'rails_helper'
require 'pry'
require_relative './../shared_examples/youtube_and_soundcloud_base_controller_spec'

RSpec.describe SongsController, type: :routing do
  let(:route) { '/videos' }
  let(:controller) { 'videos' }

  it_behaves_like 'RoutesControllers'
end

RSpec.describe VideosController, type: :controller do
  let(:params) { {  q: 'Videos de risa',
                    page: '1'  } }
  let!(:client_stub) { YoutubeService.new }
  let(:service) { YoutubeService }
  let!(:stub_response) do
    [{ :title=>"QUE ES ESTA SOLEDAD TAN BERRACA OME - VÍDEOS DE RISA DE PITODIEGO",
       :video_id=>"cUWFk9uDuPc" },
     { :title=>"Videos De Risa 2021 nuevos 😂 Videos Graciosos - Niños chistosos jugando piscinas - Pool Fails 2",
       :video_id=>"g7myAI5mC-Q" },
     { :title=>"🚨 HUMOR VIRAL #05🚨Si Te Ríes Pierdes🇲🇽😱😎😂",
       :video_id=>"Fw3B6dVBiqk" },
     { :title=>"Animales bailando reggaeton cantando chistoso Videos de risa de animalitos que bailan cumbia bailes",
       :video_id=>"UR1iG4SsvuU"},
     { :title=>"VIDEOS DE RISA 2018 - SI TE RÍES PIERDES - Peleas Momentos que no creerías Captado por la camara! #2",
       :video_id=>"HvB2xfgpweY"}]
  end

  let!(:paginated_response) do
    [{ :title=>"QUE ES ESTA SOLEDAD TAN BERRACA OME - VÍDEOS DE RISA DE PITODIEGO",
       :video_id=>"cUWFk9uDuPc" },
     { :title=>"Videos De Risa 2021 nuevos 😂 Videos Graciosos - Niños chistosos jugando piscinas - Pool Fails 2",
       :video_id=>"g7myAI5mC-Q" },
     { :title=>"🚨 HUMOR VIRAL #05🚨Si Te Ríes Pierdes🇲🇽😱😎😂",
       :video_id=>"Fw3B6dVBiqk" }]
  end

  it_behaves_like 'GetIndexSpec'
end
