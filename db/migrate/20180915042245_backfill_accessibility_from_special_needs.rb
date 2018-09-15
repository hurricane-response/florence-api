class BackfillAccessibilityFromSpecialNeeds < ActiveRecord::Migration[5.1]
  def change
    Shelter.where(special_needs: true).update_all(accessibility: 'Yes (more detail needed)')
    Shelter.where(special_needs: false).update_all(accessibility: 'No')
  end
end
