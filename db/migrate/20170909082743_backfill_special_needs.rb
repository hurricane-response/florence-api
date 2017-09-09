class BackfillSpecialNeeds < ActiveRecord::Migration[5.1]
  def change
    Shelter.where('notes ILIKE ?', '%Special Needs%')
      .update_all(special_needs: true)
  end
end
