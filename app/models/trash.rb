class Trash < ApplicationRecord
  belongs_to :user
  belongs_to :trashable, polymorphic: true, optional: true

  def restore!
    restoring = nil
    transaction do
      restoring = trashable_type.constantize.create(data)
      unless restoring && self.destroy
        restoring = nil
        raise ActiveRecord::Rollback
      end
    end
    restoring
  end
end
