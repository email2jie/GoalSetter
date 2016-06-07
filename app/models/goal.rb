class Goal < ActiveRecord::Base
  validates :user_id, :title, :description, :completion, :status,
    :kind, presence: true
  validates_inclusion_of :kind, in: ['public', 'private']
  validates_inclusion_of :status, in: %w(in_progress completed halfway_there forgotten abandoned unattainable)

  after_initialize :ensure_status!
  after_initialize :ensure_kind!

  belongs_to :user

  private

  def ensure_status!
    self.status ||= 'in_progress'
  end

  def ensure_kind!
    self.kind ||= 'public'
  end
end
