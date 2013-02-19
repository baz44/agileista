class Project < ActiveRecord::Base
  has_many :team_members, :dependent => :destroy
  has_many :people, :through => :team_members

  has_many :user_stories, :order => 'position', :dependent => :destroy
  has_many :sprints, :order => 'start_at DESC', :dependent => :destroy

  has_many :invitations, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :iteration_length
  validates_uniqueness_of :name

  def average_velocity
    return if sprints.finished.statistically_significant(self).empty?
    sprints.finished.statistically_significant(self).map {|s| s.calculated_velocity}.sum / sprints.finished.statistically_significant(self).count
  end
end