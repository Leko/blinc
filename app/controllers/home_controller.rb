class HomeController < BaseController
  before_filter :login_required, :only => 'index'

  def index
    moves = Moves::Client.new(current_user.access_token)
    profile = moves.profile['profile']

    y, m, d = [profile['firstDate'][0...4].to_i, profile['firstDate'][4...6].to_i, profile['firstDate'][6...8].to_i]
    since = Time.new y, m, d

    gon.storyline = []
    # TODO: 重すぎ。Job workerで月単位のパースを行う。
    # 0. storylineを保持する用のテーブル作成
    # 1. 進捗(completed/all)を取得し、ローカルDBに格納する
    # 2. 画面描画を早くして体感速度を上げたい
    # 3. 1週間？1ヶ月？何らかの単位でAjaxで部分取得＋部分描画を行う
    # 4. 恐らく問題ないが、分割描画にした際にjs側の描画関数を多少修正する必要あり？
    while since < Time.now do
      to = if since + 1.week > Time.now then Time.now else since + 1.week end
      storylines = moves.daily_storyline(since..to)

      storylines.each do |storyline|
        next if storyline['segments'] == nil
        gon.storyline += storyline['segments']
      end

      since += 1.week
    end
  end
end
