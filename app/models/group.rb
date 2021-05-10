class Group < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' }, 
    { id: 2, name: '1組' },
    { id: 3, name: '2組' },
    { id: 4, name: '3組' },
    { id: 5, name: '4組' }
  ]
 
   include ActiveHash::Associations
   has_many :items
  end