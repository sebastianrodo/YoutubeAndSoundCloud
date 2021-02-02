require 'rails_helper'

shared_examples_for 'RoutesControllers' do
  describe 'routes /songs to the songs controller' do
    it { expect(get: route).to route_to(controller: controller, action: 'index')  }
  end
end

shared_examples_for 'GetIndexSpec' do
  describe 'GET #index' do
    context 'expect success' do
      subject { get :index, params: params }

      before do
        expect(service).to receive(:new).and_return(client_stub)
        expect(client_stub).to receive(:init_search).with(params[:q])
                                                    .and_return(stub_response)
        expect(stub_response).to receive(:paginate).with(page: params[:page])
                                                   .and_return(paginated_response)
        subject
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template("index") }
      it { expect(assigns(:start_api)).to be_instance_of(service) }
      it { expect(assigns(:results)).to eq(paginated_response) }
    end
  end
end




