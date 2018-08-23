# frozen_string_literal: true

describe 'Activities Endpoint' do
  it 'sends a list of activities when there are activities' do
    names = %w[rastro retiro sol callao]
    names.map do |name|
      create(:activity, name: name)
    end

    get '/api/v1/activities'

    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)

    expect(json['features'].length).to eq(names.count)
  end

  it 'sends an empty list of activities when there are NO activities' do
    get '/api/v1/activities'

    json = JSON.parse(response.body)

    expect(response).to have_http_status(200)

    expect(json['features'].length).to be_zero
  end

  context 'when filtering' do
    before do
      create(:activity, category: 'shopping', district: 'Centro', location: 'outdoors')
      create(:activity, category: 'cultural', district: 'Latina', location: 'indoors')
    end

    it 'returns the right activity by category' do
      get '/api/v1/activities', params: { category: 'shopping' }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json['features'].length).to eq(1)
    end

    it 'does not return activities by an unknown category' do
      get '/api/v1/activities', params: { category: 'NOT-shopping' }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json['features'].length).to be_zero
    end

    it 'returns the right activity by district' do
      get '/api/v1/activities', params: { district: 'Centro' }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json['features'].length).to eq(1)
    end

    it 'does not return activities by an unknown district' do
      get '/api/v1/activities', params: { district: 'NOT-Centro' }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json['features'].length).to be_zero
    end

    it 'returns the right activity by location' do
      get '/api/v1/activities', params: { location: 'outdoors' }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json['features'].length).to eq(1)
    end

    it 'does not return activities by an unknown location' do
      get '/api/v1/activities', params: { location: 'NOT-outdoors' }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json['features'].length).to be_zero
    end
  end
end
