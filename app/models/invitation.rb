class Invitation < ActiveRecord::Base
  validates :email, presence: true

  def inviter_name
    user = User.find_by(id: inviter_id)
    user.full_name
  end
    
  def unsent?
    Invitation.find_by(email: self.email, inviter_id: self.inviter_id).nil?
  end
  
  def unlimited?
    n = Invitation.where(inviter_id: self.inviter_id).count
    50 > n
  end
  
end
