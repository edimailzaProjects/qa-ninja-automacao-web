class MovieAdd
  include Capybara::DSL

  def create(movie)
    find("input[name=title]").set movie["title"]

    select_status(movie["status"]) unless movie["status"].empty? #execute a menos que esteja vazio
                                                                #Não está vazio no  arquivo YALM
    find("input[name=year]").set movie["year"]
    find("input[name=release_date]").set movie["release_date"]

    add_cast(movie["cast"])

    find("textarea[name=overview]").set movie["overview"]

    upload(movie["cover"]) unless movie["cover"].empty? #unless executa se for falso
                                                      #Não está vazio no  arquivo YALM

    find("#create-movie").click
  end

  def alert
    find(".alert").text
  end

  def upload(file)
    cover_file = File.join(Dir.pwd, "features/support/fixtures/cover/" + file)
    cover_file = cover_file.tr("/", "\\") if OS.windows?

    Capybara.ignore_hidden_elements = false
    attach_file("upcover", cover_file)
    Capybara.ignore_hidden_elements = true
  end

  def add_cast(cast)
    actor = find(".input-new-tag")
    cast.each do |a|
      actor.set a
      actor.send_keys :tab #aqui é para formulários com arrays de nomes seguidos da tecla tab
    end
  end

  def select_status(status)
    # combobox - customizado com ul e li`s
    find("input[placeholder=Status]").click
    find(".el-select-dropdown__item", text: status).click
  end
end
