class ChartsController < ApplicationController
  def show
    # https://api-v2.soundcloud.com/charts?kind=top&genre=soundcloud%3Agenres%3Aall-music&client_id=02gUJC0hH2ct1EGOcYXQIzRFU91c72Ea&limit=20&offset=0
    response = HTTP.get('https://api-v2.soundcloud.com/charts', params: {
      kind: 'top',
      genre: "soundcloud:genres:#{params[:genre]}",
      client_id: ENV['SOUNDCLOUD_CLIENT_ID'],
      limit: 20,
      offset: 0
    })

    # response
    render json: format_tracks(response.parse(:json))
  end

  private

  def format_tracks(json)
    json['collection'].map do |row|
      row['track']
    end
  end
end
