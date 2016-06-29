class Seed

  def initialize
    create_causes
    create_charities
    create_need_categories
    create_needs
    create_users
    create_donations
    create_recipients
  end

  def create_charities
    20.times do
      charity = Charity.create!(
      name: Faker::Company.name,
      description: Faker::Company.bs
      )
      rand(1..3).times do
        cause = Cause.find(rand(1..10))
        if !charity.causes.includes(cause)
          charity.causes << cause
        end
      end
    end
  end

  def create_recipients
    100.times do
      Recipient.create(
      name: Faker::Name.name,
      description: Faker::Name.title,
      charity_id: Charity.find(Random.new.rand(1..20))
      )
    end
  end

  def create_users
    user = User.create(username: "jmejia@turing.io", password: "password")
    99.times do
      User.create!(
      username: Faker::Internet.user_name,
      password: Faker::Internet.password,
      email: Faker::Internet.email
      )
    end
  end

  def create_donations
    100.times do
      user = User.find(Random.new.rand(1..100))
      donation = Donation.create!(user_id: user.id)
      add_needs(donation)
    end
  end


  def create_donation_items(donation)
    10.times do
      donation_item = DonationItem.find(Random.new.rand(1..500))
      donation.needs << need
    end
  end

  def create_causes
    10.times do
      Cause.create!(
      name: Faker::Company.buzzword
      )
    end
  end

  def create_need_categories
    10.times do
      NeedsCategory.create(
      name: Faker::Commerce.department
      )
    end
  end

  def create_needs
    500.times do
      Need.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Commerce.color,
      price: Faker::Commerce.price,
      needs_category_id: NeedsCategory.find(Random.new.rand(1..10))
      )
    end
  end
end

Seed.new
