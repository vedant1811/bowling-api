class CreateGames < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :games, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps
    end
  end
end
