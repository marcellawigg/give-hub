require 'rails_helper'

RSpec.describe Family, type: :model do

  it {should have_many :categories}

  it "returns correct number of people" do
    family = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: 1, num_married_adults: 2, num_non_married_adults: 1, num_children_over_two: 2, num_children_under_two: 1)

    expect(family.num_people).to eq(6)
  end

  it "returns correct number of adults" do
    family = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: 1, num_married_adults: 2, num_non_married_adults: 1, num_children_over_two: 2, num_children_under_two: 1)

    expect(family.num_adults).to eq(3)

  end

  it "generates correct supply hash for famililes with all features" do
    family = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: 1, num_married_adults: 2, num_non_married_adults: 1, num_children_over_two: 2, num_children_under_two: 1)

    expected = {"adult" => 3,
                "person" => 6,
                "household" => 1,
                "baby" => 1,
                "child" => 2}

    expect(family.supply_quantity_hash).to eq(expected)
  end

  it "generates correct supply hash for famililes with all features" do
    family = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: 1, num_married_adults: 2, num_non_married_adults: 1, num_children_over_two: 2, num_children_under_two: 1)

    supply1 =Supply.create(name: "Full Bedframe", value: 50.0, description: "New or used.  Used must be in good condition.", multiplier: "adult" )
    supply2 =Supply.create(name: "Couch", value: 100.0, description: "New or used.  Used must be in good condition.", multiplier: "household")
    supply3 =Supply.create(name: "Kitchen Chair", value: 10.0, description: "New or used.  Used must be in good condition.", multiplier: "person")
    supply4 =Supply.create(name: "Crib", value: 50.0, description:"New or used.  Used must be in good condition.", multiplier: "baby")
    supply5 =Supply.create(name: "Backpack", value: 7.50, description:"For school-aged child.  New or used.  Used must be in good condition.", multiplier: "child")

    family.create_supply_items

    expect(family.supply_items.count).to eq(5)
    expect(family.supply_items.where(supply: supply1).quantity).to eq(3)
    expect(family.supply_items.where(supply: supply2).quantity).to eq(1)
    expect(family.supply_items.where(supply: supply3).quantity).to eq(6)
    expect(family.supply_items.where(supply: supply4).quantity).to eq(1)
    expect(family.supply_items.where(supply: supply5).quantity).to eq(2)

  end



  it "generates correct supply hash for famililes with some features" do
    family = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: 1, num_married_adults: 2, num_non_married_adults: 1, num_children_over_two: 0, num_children_under_two: 0)

    supply1 =Supply.create(name: "Full Bedframe", value: 50.0, description: "New or used.  Used must be in good condition.", multiplier: "adult" )
    supply2 =Supply.create(name: "Couch", value: 100.0, description: "New or used.  Used must be in good condition.", multiplier: "household")
    supply3 =Supply.create(name: "Kitchen Chair", value: 10.0, description: "New or used.  Used must be in good condition.", multiplier: "person")
    supply4 =Supply.create(name: "Crib", value: 50.0, description:"New or used.  Used must be in good condition.", multiplier: "baby")
    supply5 =Supply.create(name: "Backpack", value: 7.50, description:"For school-aged child.  New or used.  Used must be in good condition.", multiplier: "child")

    family.create_supply_items

    expect(family.supply_items.count).to eq(5)
    expect(family.supply_items.where(supply: supply1).quantity).to eq(3)
    expect(family.supply_items.where(supply: supply2).quantity).to eq(1)
    expect(family.supply_items.where(supply: supply3).quantity).to eq(6)
    expect(family.supply_items.where(supply: supply4).quantity).to eq(0)
    expect(family.supply_items.where(supply: supply5).quantity).to eq(0)

  end


end
