# frozen_string_literal: true

[
  'Личные вещи',
  'Транспорт',
  'Работа',
  'Для дома и дачи',
  'Недвижимость',
  'Хобби и отдых',
  'Электроника',
  'Животные',
  'Другое'
].each { |name| Category.find_or_create_by!(name:) }
