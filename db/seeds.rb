# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tool.destroy_all
Keyword.destroy_all

jelly = User.create(name: "jelly")
tracy = User.create(name: "jelly2")
shemar = User.create(name: "Tom Wap")
shemar = User.create(name: "Hey Shemar")

Tool.create([
	name: "Phaser", language: "Javascript", difficulty: 9, mod: [3], purpose: "games",
	name: "P5", language: "Javascript", difficulty: 7, mod: [3], purpose: "games",
	name: "TTY Prompt", language: "Ruby", difficulty: 1, mod: [1], purpose: "cli",
	name: "Three.js", language: "Javascript", difficulty: 10, mod: [3], purpose: "games",
	name: "Bootstrap", language: "CSS", difficulty: 3, mod: [2, 3, 4, 5], purpose: "website",
	name: "Semantic UI", language: "CSS", difficulty: 3, mod: [2, 3, 4, 5], purpose: "website"
])

Keyword.create(subject: ['educational', 'meaningful', 'health care', 'sports', 'music', 'management'], keyword_type: ['Game', 'CLI', 'Todo List', 'Scheduler', 'Blog'], purpose: ['Dogs', 'Jeff', 'Kids', 'Musicians', 'Managers'])

# idea1 = Idea.create(mod: 1, type: "Create an educational CLI with TTY Prompt for Dogs")
# idea2 = Idea.create(mod: 2, type: "Create a health care scheduler with Bootstrap for Jeff")
# idea1 = Idea.create(mod: 3, type: "Create a sports game with Three.js for Kids")
# idea1 = Idea.create(mod: 4, type: "Create a music blog with Semantic UI and React for Musicians")
# idea1 = Idea.create(mod: 5, type: "Create a management Todo List with Redux and Bootstrap for Managers")

# UserIdea.create(user_id: 1, idea_id: 2)
# UserIdea.create(user_id: 3, idea_id: 1)
# UserIdea.create(user_id: 2, idea_id: 3)
