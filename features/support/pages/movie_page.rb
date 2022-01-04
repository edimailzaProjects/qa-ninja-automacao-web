class MoviePage
  include Capybara::DSL

  def initialize #evita falsos positivos
    @movie_list_css = "table tbody tr"
  end

  def form
    MovieAdd.new
  end

  def sweet_alert
    SweetAlert.new
  end

  def add #apenas dá  o click no botão de adiconar novo filme
    find(".movie-add").click
  end

  def movie_tr(title) #passe a chave primaria de cada filme para consultar os títulos
    find(@movie_list_css, text: title)
  end

  def remove(title)
    movie_tr(title).find(".btn-trash").click #chama o próprio método de cima e busca o botão de excluir
  end

  def has_no_movie(title)
    page.has_no_css?(@movie_list_css, text: title)
  end

  def has_movie(title)
    page.has_css?(@movie_list_css, text: title)
  end
end
