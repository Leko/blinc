class MovesController < BaseController
  def storylines
    since, to = [params[:from].to_time, params[:to].to_time]
    # trackPoints => 移動中の座標も取れるようになる
    storylines = moves.daily_storyline(since.strftime('%Y-W%U'), :trackPoints => true)

    segments = []
    storylines.each do |storyline|
      next unless storyline['segments']
      storyline['segments'].each do |segment|
        if segment['type'] == 'place'
          segment.delete('activities')
          segments.push segment
        else
          segment['activities'].each do |activity|
            activity['trackPoints'].each do |trackPoint|
              segments.push({
                "place": {
                  "location": trackPoint
                }
              })
            end
          end
        end
      end
    end

    render json: segments
  end

  def places
    pp params[:id]
  end

  def profiles
    profile = moves.profile['profile']
    render json: profile
  end

  private
  def moves
    Moves::Client.new(current_user.access_token)
  end
end
