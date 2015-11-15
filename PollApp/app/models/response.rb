class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :user_is_not_author
  belongs_to :user, class_name: 'User', foreign_key: :user_id, primary_key: :id
  belongs_to :answer_choice, class_name: 'AnswerChoice', foreign_key: :answer_choice_id, primary_key: :id
  has_one :question, through: :answer_choice, source: :question


  def sibling_responses
    siblings = question.responses
    if id
      siblings.where("id != #{self.id}")
    else
      siblings
    end
  end

  def respondent_has_not_already_answered_question
    unless sibling_responses.where(user_id: user_id).empty?
      errors[:user_id] << "User has already answered question!"
    end
  end

  def user_is_not_author
    if question.poll.author_id == user_id
      errors[:user_id] << "Author can't answer own poll!"
    end
  end
end
