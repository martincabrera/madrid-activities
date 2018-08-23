describe "Activities Endpoint" do
  it 'sends a list of activities when there are activities' do

    names = %w(rastro, retiro, sol, callao)
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

  context 'when filtering with params' do
    it 'returns the right '
  end
end