json.extract! charitable_organization, :name, :services, :food_bank,
              :donation_website, :phone_number, :email, :physical_address, :city, :state, :zip

begin
  json.updatedAt charitable_organization.updated_at
rescue StandardError
  json.updatedAt 'baddate'
end
