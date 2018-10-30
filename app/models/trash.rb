class Trash < ApplicationRecord
  belongs_to :user
  belongs_to :trashable, polymorphic: true, optional: true

  after_initialize :set_resource

  def restore!
    restored = false
    transaction do
      restored = @resource.save && self.destroy
      raise ActiveRecord::Rollback unless restored
    end
    restored ? @resource : nil
  end

  def resource
    @resource
  end

private

  def set_resource
    @resource = trashable_type.constantize.new(data)
  end
end
