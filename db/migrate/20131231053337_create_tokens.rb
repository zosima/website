class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token_text
      t.references :login

      t.timestamps
    end
  end
end
