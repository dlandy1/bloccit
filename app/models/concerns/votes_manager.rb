class VotesManager

  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def up_vote!
    REDIS.multi do
       REDIS.incr post_vote_key
       REDIS.sadd post_up_voters_key, user.id
    end
    true
  end

  def down_vote!
    REDIS.multi do
      REDIS.decr post_vote_key
      REDIS.sadd post_down_voters_key, user.id
    end
    true
  end

  def remove_up_vote!
    REDIS.multi do
      REDIS.decr post_vote_key
      REDIS.srem post_up_voters_key, user.id
    end
    true
  end

  def remove_down_vote!
    REDIS.multi do
      REDIS.incr post_vote_key
      REDIS.srem post_down_voters_key, user.id
    end
    true
  end

  def already_up_voted?
    REDIS.sismember post_up_voters_key, user.id
  end

  def already_down_voted?
     REDIS.sismember post_down_voters_key, user.id
  end

  def votes_count
    REDIS.get(post_vote_key).to_i
  end

  def post_vote_key
    "post:#{post.id}:votes"
  end

  def post_up_voters_key
    "post:#{post.id}:up_voters"
  end

  def post_down_voters_key
    "post:#{post.id}:down_voters"
  end

end