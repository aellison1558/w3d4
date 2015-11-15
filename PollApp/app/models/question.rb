class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true
  belongs_to :poll, class_name: 'Poll', foreign_key: :poll_id, primary_key: :id
  has_many :answer_choices, class_name: 'AnswerChoice', foreign_key: :question_id, primary_key: :id
  has_many :responses, through: :answer_choices, source: :responses

  def results_n_plus_1
    choices = answer_choices
    results = {}
    choices.each do |choice|
      results[choice.text] = choice.responses.count
    end
    results
  end

  def results
    choices = answer_choices.includes(:responses)
    results = {}
    choices.each do |choice|
      results[choice.text] = choice.responses.count
    end
    results
  end

  def results
    choices = answer_choices.joins(:responses).group(:id).select(:text, :count)
    results = {}
    choices.each do |choice|
      results[choice.text] = choice.count
    end
    results
  end

end
