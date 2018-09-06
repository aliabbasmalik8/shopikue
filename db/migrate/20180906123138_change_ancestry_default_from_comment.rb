class ChangeAncestryDefaultFromComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :ancestry , :string ,default: nil
  end
end
