`clear`
`mysql --user=treithinger --password=balls --database="concerto_tom" --execute="TRUNCATE contents; TRUNCATE feeds; TRUNCATE groups; TRUNCATE memberships; TRUNCATE submissions; TRUNCATE users;"`

guest = User.new(is_super_user: false);
User.accessor = guest

u = User.new(username: "dong", email: "dong@example.com", first_name: "Senor", last_name: "Rubenstein", is_super_user: true)
u1 = User.new(username: "troll", email: "troll@example.com", first_name: "Senor", last_name: "Trollface", is_super_user: false)

gX = Group.new(name: "Group X")
gY = Group.new(name: "Group Y")
gZ = Group.new(name: "Group Z")

u.save!
u1.save!

gX.save!

User.accessor = u1

gX.save!
gY.save!
gZ.save!

m = gX.memberships

User.accessor = guest

x = Group.find(1)

gX.is_moderator?(guest)
gX.is_moderator?(u1)
