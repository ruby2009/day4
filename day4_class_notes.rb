class Movie

  attr_accessor :title, :budget, :stars

  def initialize (title:, budget:, stars:)
    @title = title
    @budget = budget
    @stars = stars
  end

  def stars?(actor)
    stars.include? actor
  end

  def cheap?
    budget < 100
  end

  def >(other)
    budget > other.budgetend
  end

  def <(other)
    budget < other.budget
  end

  def ==(other)
    (!self.< other.budget) && (!self.> other.budget)
  end

end

movies = []
movies << {
  title: "Forest Gump",
  budget: 55,
  stars: ["Tom Hanks"]
}
movies << {
  title: "Star Wars",
  budget: 11,
  stars: ["Mark Hamill", "Harrison Ford"]
}
movies << {
  title: "Batman Begins",
  budget: 150,
  stars: ["Christian Bale", "Liam Neeson", "Michael Caine"]
}
movies << {
  title: "Titanic",
  budget: 200,
  stars: ["Kate Winslet", "Leonardo DiCaprio"]
}
movies << {
  title: "Inception",
  budget: 160,
  stars: ["Leonardo DiCaprio", "JGL"]
}

movie_objects = movies.collect do |film|
                  Movie.new(
                  film
                  )
                end

cheapies = movie_objects.select{|film| film.cheap?}.collect(&:title)

puts "Our cheap movies are: #{cheapies.join(" and")}"


leos = movie_objects.select{|film| film.stars? "Leonardo DiCaprio"}

puts "Our Leo movies were: #{leos.join(" and ")}"

puts movie_objects.cheap?
