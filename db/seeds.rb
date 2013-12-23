# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
# . . .
Product.create(title: 'Programming Ruby 1.9',
description:
%{<p>
Ruby is the fastest growing and most exciting dynamic language
out there. If you need to get working programs delivered fast,
you should add Ruby to your toolbox.
</p>},
image_url: 'ruby.png',
price: 49.95)
# . . .
Product.create(title: 'product_1',
description:
%{<p>
product_1_description
</p>},
image_url: 'Ranma 01.jpg',
price: 49.96)
# . . .
Product.create(title: 'product_2',
description:
%{<p>
product_2_description
</p>},
image_url: 'Ranma 02.jpg',
price: 49.97)
# . . .
Product.create(title: 'product_3',
description:
%{<p>
product_3_description
</p>},
image_url: 'Ranma 03.jpg',
price: 49.98)
# . . .
Product.create(title: 'product_4',
description:
%{<p>
product_4_description
</p>},
image_url: 'Ranma 04.jpg',
price: 49.99)
# . . .