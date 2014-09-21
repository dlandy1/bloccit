class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
    mount_uploader :image, ImageUploader

  belongs_to :user
   belongs_to :topic

    default_scope { order('rank DESC') }
    scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

    validates :title, length: {minimum: 5}, presence: true
    validates :body, length: {minimum: 20}, presence: true
    validates :topic, presence: true
    validates :user, presence: true

    def already_up_voted_by_user?(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.already_up_voted?
    end

    def already_down_voted_by_user?(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.already_down_voted?
    end

    def up_votes
      vote_manager = VotesManager.new(nil, self)
      vote_manager.votes_count
    end

    def down_vote!(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.down_vote!
    end

    def up_vote!(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.up_vote!
      #user.votes.create(value: 1, post: self)
    end

    def remove_up_vote!(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.remove_up_vote!
    end

    def remove_down_vote!(voting_user)
      vote_manager = VotesManager.new(voting_user, self)
      vote_manager.remove_down_vote!
    end

    def points
      vote_manager = VotesManager.new(nil, self)
      vote_manager.votes_count
    end

    def markdown_title
      render_as_markdown title
    end

    def markdown_body
      render_as_markdown body
    end

   def update_rank
      age = (self.created_at - Time.new(1970,1,1)) / (86400)
      new_rank = self.points + age

      self.update_attribute(:rank, new_rank)
    end 

    def save_with_initial_vote
      ActiveRecord::Base.transaction do 
        self.save 
        self.up_votes
      end
    end

    private   

    def render_as_markdown(text)
      renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      (redcarpet.render text).html_safe
    end
end
