class CommonQuestion
  def initialize(question, answer, slug)
    @question = question
    @answer = answer
    @slug = slug

end

attr_reader :question
attr_reader :answer
attr_reader :slug

end
