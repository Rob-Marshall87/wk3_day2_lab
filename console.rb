require('pry-byebug')
require_relative('models/bounties')

bounty1 = Bounty.new( {'name' => 'Boba Fett', 'species' => 'Mandelorian', 'bounty_value' => '50', 'danger_level' => 'high'} )
bounty2 = Bounty.new( {'name' => 'Jango Fett', 'species' => 'Mandelorian', 'bounty_value' => '93', 'danger_level' => 'moderate'} )
bounty3 = Bounty.new( {'name' => 'IG-88', 'species' => 'Robot', 'bounty_value' => '38', 'danger_level' => 'low'} )


Bounty.delete_all

bounty1.save()

bounty2.save()

bounty3.save()

bounty2.bounty_value = '200'
bounty2.update()

# bounty1.delete()

p Bounty.find_by_name('Boba Fett')
# p Bounty.find_by_name('Bob Feta')

p Bounty.find_by_id(78)
