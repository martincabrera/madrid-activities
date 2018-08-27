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

  describe '.recommendation' do
    context 'when some params are missing' do
      it 'returns a 422' do
        get '/api/v1/activities/recommendation', params: { category: 'shopping' }
        expect(response).to have_http_status(422)
      end
    end

    context 'when all params are there' do
      let(:first_activity) do
        create(:activity, category: 'shopping', district: 'Centro', location: 'outdoors',
                          name: 'El Rastro')
      end
      let(:second_activity) do
        create(:activity, category: 'shopping', district: 'Latina', location: 'indoors',
                          name: 'Latina museum', hours_spent: 1)
      end
      before do
        create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                              end_hour: TimeFormatter.hours_minutes_to_seconds('20:30'), day_of_the_week: 'mo')
        create(:opening_hour, activity: second_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                              end_hour: TimeFormatter.hours_minutes_to_seconds('20:30'), day_of_the_week: 'mo')
      end

      it 'returns expected activity' do
        params = { start_hour: '19:00', end_hour: '20:30', day_of_the_week: 'mo', category: 'shopping' }
        get '/api/v1/activities/recommendation', params: params

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['properties']['name']).to eq(second_activity.name)
      end
    end
  end
end
