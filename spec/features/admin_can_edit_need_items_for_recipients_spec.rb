require 'rails_helper'

RSpec.feature "admin edits need items for recipient" do
  scenario "need items are edited by business admin" do
    role = Role.find_by(name: "Business Admin")
    user = create(:user)
    charity = create(:charity)
    status = create(:status)
    user_role = UserRole.create(role_id: role.id,
                                user_id: user.id,
                                charity_id: charity.id)
    need = charity.needs.create(name: "Need-1",
                                description: "description for Need-1",
                                price: 10,
                                needs_category: create(:needs_category))
    recipient = Recipient.create(name: "Recipient",
                                 description: "Recipient description",
                                charity_id: charity.id)
    need_item = NeedItem.create(need_id: need.id , recipient_id: recipient.id,
                                quantity: 2,  deadline: "2016-07-24 00:00:00")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "Details"
    end

    expect(current_path).to eq (admin_charity_recipient_path(charity.slug, recipient))

    within ".#{need_item.name}-row" do
      click_on "Edit Need"
    end

    expect(current_path).to eq(edit_admin_charity_recipient_need_item_path(charity.slug, recipient, need_item))

    select 7, from: "need_item[quantity]"
    fill_in "need_item[deadline]", with: "2016/07/22"

    click_on "Update Need"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, recipient))

    within(".#{need.name}") do
      expect(page).to have_content(need.name)
    end

    need_item_quantity = recipient.need_items.find_by(need_id: need.id).quantity

    within(".quantity-#{need_item_quantity}") do
      expect(page).to have_content(7)
    end

    expect(page).to have_content("July 22, 2016")
  end

  scenario "need items are edited by business owner" do
    role = Role.find_by(name: "Business Owner")
    user = create(:user)
    charity = create(:charity)
    status = create(:status)
    user_role = UserRole.create(role_id: role.id,
                                user_id: user.id,
                                charity_id: charity.id)
    need = charity.needs.create(name: "Need-1",
                                description: "description for Need-1",
                                price: 10,
                                needs_category: create(:needs_category))
    recipient = Recipient.create(name: "Recipient",
                                 description: "Recipient description",
                                charity_id: charity.id)
    need_item = NeedItem.create(need_id: need.id , recipient_id: recipient.id,
                                quantity: 2,  deadline: "2016-07-24 00:00:00")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "Details"
    end

    expect(current_path).to eq (admin_charity_recipient_path(charity.slug, recipient))

    within ".#{need_item.name}-row" do
      click_on "Edit Need"
    end

    expect(current_path).to eq(edit_admin_charity_recipient_need_item_path(charity.slug, recipient, need_item))

    select 7, from: "need_item[quantity]"
    fill_in "need_item[deadline]", with: "2016/07/22"

    click_on "Update Need"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, recipient))

    within(".#{need.name}") do
      expect(page).to have_content(need.name)
    end

    need_item_quantity = recipient.need_items.find_by(need_id: need.id).quantity

    within(".quantity-#{need_item_quantity}") do
      expect(page).to have_content(7)
    end

    expect(page).to have_content("July 22, 2016")
  end

  scenario "admin cannot forcibly see a recipient from anotoher charity through charity's slug" do
    role = Role.find_by(name: "Business Owner")
    user = create(:user)
    charity1, charity2 = create_list(:charity, 2)
    user_role = UserRole.create(role_id: role.id,
                                user_id: user.id,
                                charity_id: charity1.id)
    other_recipient = charity2.recipients.create(name: "test", description: "test")

    visit "admin/#{charity1.slug}/recipients/#{other_recipient.id}"

    expect(current_path).to_not eq(charity_path(charity1.slug))

  end

end
