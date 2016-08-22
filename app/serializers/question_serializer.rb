class QuestionSerializer < ActiveModel::Serializer

  self.root = false

  ## defaults
  attributes  :id # => , :created_at, :updated_at

  ## instance-attributes
  attributes  :text, :answer1, :answer2, :answer3, :result

end