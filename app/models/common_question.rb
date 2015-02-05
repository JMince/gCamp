class CommonQuestion
  def initialize(question, answer)
    @question = question
    @answer = answer
    @slug = @question.gsub(" ", "-")

end

attr_reader :question
attr_reader :answer
attr_reader :slug

end
