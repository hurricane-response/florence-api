module Trashable
  extend ActiveSupport::Concern

  included do
    has_one :trash, as: :trashable
  end

  def trash!(user, reason = nil)
    transaction do
      trash = Trash.create(trashable: self,
                   user: user,
                   data: self.attributes,
                   reason: reason)
      unless trash && self.destroy
        trash = nil
        raise ActiveRecord::Rollback
      end
    end
    trash
  end
end
