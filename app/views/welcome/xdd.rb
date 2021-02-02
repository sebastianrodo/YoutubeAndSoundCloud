context 'with keys' do
  let(:client_stub) do
    Aws::S3::Client.new(region: ENV['AWS_TEMP_DIRECT_REGION'],
      access_key_id: ENV['AWS_TEMP_DIRECT_KEY'],
      secret_access_key: ENV['AWS_TEMP_DIRECT_SECRET_KEY'],
      stub_responses: true)
  end
​
  let(:key_1) { 'avatar.jpg' }
  let(:key_2) { 'lesson-template.docx' }
  let(:keys) { [key_1, key_2] }
​
  let!(:s3_resp_1) do
    instance_double('S3::Object', body: File.open(Rails.root.join('spec', 'fixtures', 'files', key_1)),
                                  content_type: 'png')
  end
​
  let!(:s3_resp_2) do
    instance_double('S3::Object', body: File.open(Rails.root.join('spec', 'fixtures', 'files', key_2)),
                                  content_type: 'docx')
  end
​
  before do
    expect(Aws::S3::Client).to receive(:new).with(region: ENV['AWS_TEMP_DIRECT_REGION'],
                                                 access_key_id: ENV['AWS_TEMP_DIRECT_KEY'],
                                                 secret_access_key: ENV['AWS_TEMP_DIRECT_SECRET_KEY'])
                                           .and_return(client_stub)
​
    expect(client_stub).to receive(:get_object).with(bucket: ENV['AWS_TEMP_DIRECT_BUCKET'],
                                                     key: key_1).ordered.and_return(s3_resp_1)
​
    expect(client_stub).to receive(:get_object).with(bucket: ENV['AWS_TEMP_DIRECT_BUCKET'],
                                                     key: key_2).ordered.and_return(s3_resp_2)
    subject
  end
​
  it { expect(conversation.messages.count).to eq(2) }
  it { expect(conversation.reload.messages.first.file.attached?).to be_truthy }
  it { expect(conversation.reload.messages.second.file.attached?).to be_truthy }
end


require 'rails_helper'
​
RSpec.describe API::V2::Assignments::Cycles::Organizations::GroupsController, type: :routing do
  it { is_expected.to route(:get, '/api/v2/assignments/cycles/1/organizations/1/groups').to(format: 'json', action: 'index', cycle_id: "1", organization_id: "1") }
end
​
RSpec.describe API::V2::Assignments::Cycles::Organizations::GroupsController, type: :controller do
  describe 'GET #index' do
    let(:super_admin){ create(:user, :as_super_admin) }
    let(:organization) { create(:organization) }
​
    let!(:group) { create(:group, organization: organization) }
    let!(:group_2) { create(:group, organization: organization) }
​
    let(:cycle) { create(:cycle) }
​
​
    let(:params) { { organization_id: organization.id, cycle_id: cycle.id } }
​
    before do
      sign_in super_admin
      create(:cycle_assignment, assignable: group, cycle: cycle)
      get :index, params: params
    end
​
    it { expect(response.status).to eq(200) }
    it { expect(json_response['groups'].size).to eq 2 }
    it { expect(json_response['groups'].map{|g| g["id"] }).to include group_2.id }
    it { expect(json_response['groups'].map{|g| g["id"] }).not_to include group.id }
  end
end

it 'renders signup page prefilling user data' do
  get :new, params: {info: token}
  expect(response).to render_template("new")
  expect(assigns(:new_user_attr)).to include({ email: 'chopi@email.com' })
end

