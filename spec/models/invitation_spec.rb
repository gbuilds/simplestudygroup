require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  it "#unsent?" do
    create(:invitation, inviter_id: 1)
    second_invitation = build(:invitation, inviter_id: 1)
    expect(second_invitation.unsent?).to eq false
  end
end
