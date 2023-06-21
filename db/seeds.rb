# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create(name: "Pessoal")
Category.create(name: "Estudos")
Category.create(name: "Empresarial")


Post.create(title: "Facu na unibas", content: "Como a faculdade é difícil pelo amor de deus #cansado, não espero as férias chegarem")
PostCategory.create(post_id: 1, category_id: 1)
PostCategory.create(post_id: 1, category_id: 2)
Post.create(title: "Cálculo I", content: "A última prova de cálculo I de 2023.1 será dia 14/07, venha estudar com a gente pelo nosso discord")
PostCategory.create(post_id: 2, category_id: 2)
PostCategory.create(post_id: 2, category_id: 1)
Post.create(title: "Ibovespa", content: "Hoje, devido à situação caótica da política internacional, o Ibovespa sentiu uma queda de 1,3%")
PostCategory.create(post_id: 3, category_id: 3)
PostCategory.create(post_id: 3, category_id: 2)


Feedback.create(like: :true, post_id: 1)
Feedback.create(like: :false, post_id: 1)
Feedback.create(like: :true, post_id: 2)
Feedback.create(like: :false, post_id: 2)
Feedback.create(like: :true, post_id: 3)
Feedback.create(like: :false, post_id: 3)

Comment.create(content: 'Nossa, realmente, estou na mesma. Engenharia não tá fácil pra ninguém, comecei agora só que ja quero minhas férias.', post_id: 1)
Comment.create(content: 'Que nada, a faculdade é boa demais, eu só fico de resenha o dia todo jogando uma sinuquinha', post_id: 1)
Comment.create(content: 'Opa, eu vou querer emm. Esse conteúdo novo de integral ta meio foda...', post_id: 2)
Comment.create(content: 'Que massa, se pa apareco nesse discord aí, to meio mal em cálculo!', post_id: 2)
Comment.create(content:'O mercado anda muito instável, tenho muitas aplicações na bolsa e confesso que estou preocupado...', post_id: 3)
Comment.create(content: 'Da nada, jaja o ibovespa sobe de novo com certeza!!', post_id: 3)